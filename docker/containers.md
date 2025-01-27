# List of containers I have installed and used

## Ollama

https://hub.docker.com/r/ollama/ollama

To run (CPU only):

```
docker run -d -v ollama:/root/.ollama -p 11434:11434 --name ollama ollama/ollama
``` 

Run model locally

```
docker exec -it ollama ollama run llama3
```

https://github.com/ollama/ollama


----
# Repos and links
[Hugging Face](https://huggingface.co) : The AI community building the future.
