# https://blog.patshead.com/2011/04/improve-your-oh-my-zsh-startup-time-maybe.html
skip_global_compinit=1

# http://disq.us/p/f55b78
setopt noglobalrcs

export SYSTEM=$(uname -s)

# https://github.com/sorin-ionescu/prezto/blob/master/runcoms/zshenv
# Ensure that a non-login, non-interactive shell has a defined environment.
if [[ ( "$SHLVL" -eq 1 && ! -o LOGIN ) && -s "${ZDOTDIR:-$HOME}/.zprofile" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprofile"
fi

OLLAMA_API_BASE=0.0.0.0:11211
OLLAMA_CORS=true
OLLAMA_FLASH_ATTENTION=1
OLLAMA_HOST=0.0.0.0
OLLAMA_KEEP_ALIVE=3600
OLLAMA_KV_CACHE_TYPE=q8_0
OLLAMA_ORIGINS='*'

# uv
export PATH="/Users/bernardobotellacorbi/.local/bin:$PATH"
