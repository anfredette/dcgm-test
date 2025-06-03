#!/bin/bash

# This script can be used to test the LLM-D inference gateway by repeatedly
# sending random prompts to the gateway and printing the responses.
#
# It requrires that jq be installed and that the LLM-D inference gateway be
# running.  It assumes you're using the Minikube deployment described here:
# https://github.com/llm-d/llm-d-deployer/blob/main/quickstart/README-minikube.md


MINIKUBE_IP=$(minikube ip)
NODEPORT=$(kubectl get svc llm-d-inference-gateway -n llm-d -o jsonpath='{.spec.ports[0].nodePort}')
MODEL_ID=$(curl -s http://$MINIKUBE_IP:$NODEPORT/v1/models | jq -r '.data[0].id')

echo "MINIKUBE_IP: $MINIKUBE_IP"
echo "NODEPORT: $NODEPORT"
echo "MODEL_ID: $MODEL_ID"
echo "--------------------------------"

PROMPTS=(
  "What is the capital of France?"
  "Who was Ada Lovelace?"
  "Explain gravity to a child."
  "What is a black hole?"
  "Define machine learning."
  "Tell me a joke."
  "What is photosynthesis?"
  "Describe the water cycle."
  "What is an atom?"
  "What is a democracy?"
  "Summarize 'Romeo and Juliet'."
  "What causes the seasons?"
  "What is the internet?"
  "How does a car engine work?"
  "Explain evolution."
  "What is the largest planet?"
  "How does a computer work?"
  "What is a neuron?"
  "Why do we dream?"
  "What is the speed of light?"
  "What is artificial intelligence?"
  "What is the human genome?"
  "How does a magnet work?"
  "Why is the sky blue?"
  "What is quantum computing?"
)

while true; do
  PROMPT=${PROMPTS[$RANDOM % ${#PROMPTS[@]}]}
  echo -e "\n🔹 Prompt: $PROMPT"

  RESPONSE=$(curl -s -X POST http://${MINIKUBE_IP}:${NODEPORT}/v1/completions \
    -H 'accept: application/json' \
    -H 'Content-Type: application/json' \
    -d '{
      "model": "'"${MODEL_ID}"'",
      "prompt": "'"${PROMPT}"'"
    }' | jq -r '.choices[0].text // "No response text."')

  echo -e "🟢 Response: ${RESPONSE}"
  echo -e "\n---\n"
  # sleep 5
done
