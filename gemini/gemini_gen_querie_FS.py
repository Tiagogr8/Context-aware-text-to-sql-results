import os
import google.generativeai as genai
from dotenv import load_dotenv

# === CONFIG ===
schema_file = "../schema.txt"
descriptions_dir = "../queries_descriptions"
queries_dir = "../original_queries/queries"  # Directory with the SQL examples
outputs_dir = "results_FS"
num_examples = 3  # Number of few-shot examples

# Priority order for examples (customize based on query complexity/representativeness)
example_priority = ["q2", "q3", "q4", "q5"]

# Gemini Model
model_name = "gemini-2.5-pro"

# Load Gemini API key
load_dotenv()
GEMINI_API_KEY = os.getenv("GEMINI_API_KEY", "YOUR_API_KEY_HERE")

# Configure Gemini
genai.configure(api_key=GEMINI_API_KEY)

os.makedirs(outputs_dir, exist_ok=True)

# === System instruction ===
instruction = """
You are a SQL expert.
Using the database schema and the examples provided, generate a valid PostgreSQL query that answers the question.
Return ONLY the SQL code without any markdown formatting or explanations.
"""

# === Read schema ===
with open(schema_file, "r") as f:
    schema_text = f.read()


def get_few_shot_examples(target_query, n=3):
    """
    Select n examples from priority list, excluding the target query.
    """
    examples = []
    for query_name in example_priority:
        if query_name == target_query:
            continue  # Skip the target query
        
        desc_path = os.path.join(descriptions_dir, f"{query_name}_description.txt")
        sql_path = os.path.join(queries_dir, f"{query_name}.sql")
        
        # Check if both files exist
        if not os.path.exists(desc_path) or not os.path.exists(sql_path):
            continue
        
        try:
            with open(desc_path, "r") as f:
                description = f.read().strip()
            with open(sql_path, "r") as f:
                sql = f.read().strip()
            
            examples.append({
                "name": query_name,
                "description": description,
                "sql": sql
            })
            
            if len(examples) == n:
                break
        except Exception as e:
            print(f"⚠️ Warning: Could not load example {query_name}: {e}")
            continue
    
    return examples


def build_few_shot_prompt(schema, examples, target_question):
    """
    Build the few-shot prompt with examples.
    """
    prompt = f"DATABASE SCHEMA:\n{schema}\n\n"
    
    # Add examples
    prompt += "Here are some examples of questions and their corresponding SQL queries:\n\n"
    for i, ex in enumerate(examples, 1):
        prompt += f"--- EXAMPLE {i} ---\n"
        prompt += f"QUESTION:\n{ex['description']}\n\n"
        prompt += f"SQL QUERY:\n{ex['sql']}\n\n"
    
    # Add target question
    prompt += "--- YOUR TASK ---\n"
    prompt += f"QUESTION:\n{target_question}\n\n"
    prompt += "Generate the SQL query for this question following the same pattern as the examples above.\n"
    
    return prompt


def generate_sql(schema, question, examples):
    prompt = build_few_shot_prompt(schema, examples, question)
    
    print("🧠 Sending request to Gemini...")
    
    try:
        model = genai.GenerativeModel(
            model_name=model_name,
            system_instruction=instruction
        )
        
        response = model.generate_content(
            prompt,
            generation_config=genai.GenerationConfig(
                temperature=0.0,
            )
        )
        
        sql = response.text.strip()
        
        # Clean output (remove markdown if present)
        if sql.startswith("```sql"):
            sql = sql[6:]
        if sql.startswith("```"):
            sql = sql[3:]
        if sql.endswith("```"):
            sql = sql[:-3]
        
        sql = sql.strip()
        return sql
        
    except Exception as e:
        raise Exception(f"Gemini API Error: {str(e)}")


# === Process all descriptions ===
for filename in os.listdir(descriptions_dir):
    if filename.endswith("_description.txt"):
        query_name = filename.replace("_description.txt", "")
        description_path = os.path.join(descriptions_dir, filename)

        with open(description_path, "r") as f:
            description_text = f.read()

        print(f"\n{'='*60}")
        print(f"🚀 Generating SQL for: {query_name}")
        print(f"{'='*60}")

        # Get few-shot examples (excluding current query)
        examples = get_few_shot_examples(query_name, n=num_examples)
        
        if len(examples) < num_examples:
            print(f"⚠️ Warning: Only found {len(examples)} examples for {query_name}")
        
        print(f"📚 Using examples: {[ex['name'] for ex in examples]}")

        try:
            sql_query = generate_sql(schema_text, description_text, examples)
        except Exception as e:
            print(f"❌ Error generating SQL for {query_name}: {e}")
            continue

        output_path = os.path.join(outputs_dir, f"{query_name}.sql")
        with open(output_path, "w") as f:
            f.write(sql_query)

        print(f"✅ Saved to: {output_path}")
        print(f"---\n{sql_query}\n---")

print(f"\n🎉 All queries processed! Results saved in: {outputs_dir}")