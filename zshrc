# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="af-magic"

# Uncomment the following line to enable command auto-correction.
 ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

[[ -s /Users/darren/.autojump/etc/profile.d/autojump.sh ]] && source /Users/darren/.autojump/etc/profile.d/autojump.sh

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
# plugins=(git mvn autojump zsh-autosuggestions golang docker)

plugins=(git mvn autojump zsh-autosuggestions )

# User configuration

export PATH=$HOME/bin:/usr/local/bin:$PATH
# export MANPATH="/usr/local/man:$MANPATH"

source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

export LC_ALL=en_US.UTF-8 
export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

alias zshconfig="vim  ~/.zshrc"
alias ohmyzsh="vim ~/.oh-my-zsh"

alias vi='vim'

alias _='sudo'
alias ...='cd ../..'
alias -- -='cd -'

alias ll='ls -alF'
alias la='ls -A'
alias lh='ll -d .*'
alias l='ls -CF'

alias rmf='rm -f'
alias rmrf='rm -rf'

alias grep="grep --color=auto"


alias updatedb='sudo /usr/libexec/locate.updatedb'
alias clearDnsCache='sudo discoveryutil mdnsflushcache'
alias aria2cx='/usr/local/Cellar/aria2/1.31.0/bin/aria2c --enable-rpc --rpc-listen-all=true --rpc-allow-origin-all -c'


alias javac="javac -J-Dfile.encoding=utf8"
alias mvncstd="git pull && mvn clean deploy -Dmaven.test.skip=true"

alias minikube19='minikube start --kubernetes-version=v1.19.2 --driver=hyperkit --image-mirror-country=cn --cpus=2 --memory=4g'

###########################################################################

## GRADLE
export GRADLE_HOME=/usr/local/opt/gradle

## MAVEN
export MAVEN_OPTS="-Xms512m -Xmx1024m"
export MAVEN_HOME="/usr/local/opt/maven"
export M2_HOME="/usr/local/opt/maven"

##GROOVY 
export GROOVY_HOME=/usr/local/opt/groovy/libexec

## JAVA
# export JAVA_VERSION="1.8.0_172"
export JAVA_HOME=$(/usr/libexec/java_home -v 1.8.0_172)
export CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar:$CLASSPATH

## GOLANG
export GOPATH=/Users/darren/go
export PATH=$OSS_CMD:$JAVA_HOME:$GROOVY_HOME/bin:$GOPATH/bin:$PATH

export GOPROXY="https://goproxy.cn,https://mirrors.aliyun.com/goproxy,direct"

#export CLICOLOR=1

#
DISABLE_UPDATE_PROMP=true

if [ /usr/local/bin/kubectl ]; then source <(kubectl completion zsh); fi
