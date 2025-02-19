cd ~/

wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh

chmod +x Miniconda3-latest-Linux-x86_64.sh

bash Miniconda3-latest-Linux-x86_64.sh -b

rm Miniconda3-latest-Linux-x86_64.sh

export USER=$(whoami)
__conda_setup="$(/home/$USER/miniconda3/bin/conda shell.bash hook)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/$USER/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/$USER/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/$USER/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup

rm ~/.local/bin/pip*

pip install -q -U keras-nlp tensorflow-text
pip install -q -U tensorflow-cpu
