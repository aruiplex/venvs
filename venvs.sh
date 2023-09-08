venvs() {
    # Default root path for virtual environments
    local venvs_root="${venvs_path:-$HOME/venvs}"
    
    # If no argument is provided, default to "torch"
    local select_venv="torch"
    
    # Check if an argument is provided
    if [ $# -ge 1 ]; then
        if [[ -d "$venvs_root/$1" ]]; then
            select_venv="$1"
        else
            echo "No virtualenv named $1 :)"
            return 1
        fi
    fi
    
    local activation="$venvs_root/$select_venv/bin/activate"
    
    if [[ -f "$activation" ]]; then
        echo "Activating virtual environment: $select_venv"
        source "$activation"
    else
        echo "Error: Activation script not found for $select_venv"
        return 1
    fi
}


_venvs_complete() {
    local venvs_root="${venvs_path:-$HOME/venvs}"
    local word="${2}"
    
    local suggestions=$(ls "$venvs_root" | grep "^$word")
    COMPREPLY=( $(compgen -W "${suggestions}" -- "${word}") )
}

complete -F _venvs_complete venvs
