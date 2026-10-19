# backend/app/services/nlp_service.py
import os
import re
from google import genai
from google.genai import types


class DistressAnalyzer:
    # 1. Hardened Crisis Pattern Detector for immediate intervention
    CRISIS_PATTERNS = [
        r"\b(die|dieing|dying|death|kill|end my life|harm|hurt myself)\b",
        r"\b(suicide|suicidal|self-harm|selfharm)\b",
        r"\bwant to die\b|\bwanna die\b|\bkill myself\b|\bdont want to live\b"
    ]

    # Initialize Gemini Client (Uses environment variable GEMINI_API_KEY)
    client = genai.Client(api_key=os.environ.get("GEMINI_API_KEY", "YOUR_GEMINI_API_KEY"))

    SYSTEM_INSTRUCTION = """
    You are SafeSpace AI, an empathetic, supportive, and active-listening mental health companion.
    Your goal is to validate user feelings, reduce emotional distress, and offer gentle grounding tips.

    Guidelines:
    1. Always maintain a warm, non-judgmental, friendly, and compassionate tone. Use gentle purple heart (💜) or leaf (🌱) emojis occasionally.
    2. Keep responses concise (2-4 sentences max) so overwhelmed users can easily read them.
    3. Suggest small actionable grounding steps (e.g., taking slow breaths or trying a calming activity).
    4. NEVER provide medical diagnoses or act as a licensed medical professional.
    """

    @classmethod
    def analyze_text(cls, text: str) -> dict:
        clean_text = text.lower().strip()

        # Step A: High-Priority Safety Override (Immediate Hotline Routing)
        for pattern in cls.CRISIS_PATTERNS:
            if re.search(pattern, clean_text):
                return {
                    "sentiment_level": "CRISIS",
                    "override_triggered": True,
                    "response": (
                        "I am so glad you reached out to me, but please know you don't have to carry this heavy weight alone. 💜\n\n"
                        "Your life matters, and there is immediate help available:\n"
                        "• Step away from anything harmful right now.\n"
                        "• Call Tele-MANAS at 14416 (India) for immediate, compassionate support.\n"
                        "• Reach out to someone you trust nearby.\n\n"
                        "Let's get you connected to help right away."
                    )
                }

        # Step B: AI Conversational Support via Gemini
        try:
            response = cls.client.models.generate_content(
                model="gemini-2.5-flash",
                contents=text,
                config=types.GenerateContentConfig(
                    system_instruction=cls.SYSTEM_INSTRUCTION,
                    temperature=0.7,
                    max_output_tokens=250,
                )
            )

            return {
                "sentiment_level": "NORMAL",
                "override_triggered": False,
                "response": response.text
            }

        except Exception as e:
            # Fallback in case of API timeout/error
            return {
                "sentiment_level": "NORMAL",
                "override_triggered": False,
                "response": "I hear you, and I am here for you. 💜 Even when things feel chaotic, take it one small breath at a time. What is on your mind right now?"
            }