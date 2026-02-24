

# TODO: check if available:
# - suml
# - ~/home/summary-link/prompts/title.md 

head "$PWD/${1}" \ 
  | suml --provider ollama -P ~/home/summary-link/prompts/title.md -m gemma3:1b --quiet --silent 2> /dev/null \
  | grep -v dotenv
