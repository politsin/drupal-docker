#------------------------
# Глобальные определения
#------------------------

if [ -f /etc/bashrc ]; then
        . /etc/bashrc   # --> Прочитать настройки из /etc/bashrc, если таковой имеется.
fi

#-------
# Цвета
#-------

txtblk='\e[0;30m' # Black - Regular
txtred='\e[0;31m' # Red
txtgrn='\e[0;32m' # Green
txtylw='\e[0;33m' # Yellow
txtblu='\e[0;34m' # Blue
txtpur='\e[0;35m' # Purple
txtcyn='\e[0;36m' # Cyan
txtwht='\e[0;37m' # White
bldblk='\e[1;30m' # Black - Bold
bldred='\e[1;31m' # Red
bldgrn='\e[1;32m' # Green
bldylw='\e[1;33m' # Yellow
bldblu='\e[1;34m' # Blue
bldpur='\e[1;35m' # Purple
bldcyn='\e[1;36m' # Cyan
bldwht='\e[1;37m' # White
unkblk='\e[4;30m' # Black - Underline
undred='\e[4;31m' # Red
undgrn='\e[4;32m' # Green
undylw='\e[4;33m' # Yellow
undblu='\e[4;34m' # Blue
undpur='\e[4;35m' # Purple
undcyn='\e[4;36m' # Cyan
undwht='\e[4;37m' # White
bakblk='\e[40m'   # Black - Background
bakred='\e[41m'   # Red
badgrn='\e[42m'   # Green
bakylw='\e[43m'   # Yellow
bakblu='\e[44m'   # Blue
bakpur='\e[45m'   # Purple
bakcyn='\e[46m'   # Cyan
bakwht='\e[47m'   # White
NC='\e[0m'    # Text Reset

# некоторые цвета:
red='\e[0;31m'
RED='\e[1;31m'
blue='\e[0;34m'
BLUE='\e[1;34m'
cyan='\e[0;36m'
CYAN='\e[1;36m'

#-----------------------
# Greeting, motd etc...
#-----------------------

function ii()   # Дополнительные сведения о системе
{
    IP=$(ifconfig  | grep 'inet addr:'| grep -v '127.0.0.1' | cut -d: -f2 | awk '{ print $1}')

    echo -e "\n${bldblu}`hostname`$NC $IP"
    
    echo -e "${bldblu}Дата:   $NC `date`"

    echo -e "${bldblu}Аптайм:$NC `uptime`"
    
    echo -e "${bldblu}Инфо:   $NC $(uname -srvm)"

    echo -e "\n${bldblu}Память :$NC " ; free
    
    echo -e "\n${bldblu}Открытые сеансы:$NC " ; w -h

    echo
}

ii

#-----------------------------
# Некоторые настройки
#-----------------------------

shopt -s histappend           # Так история команд будет добавляться к старой, а не перезаписывать ее,
PROMPT_COMMAND='history -a'   # и запись будет происходить каждый раз в момент отображения подсказки bash.

shopt -s cdspell              # Таким образом ошибки в написании (например, ect вместо etc) будут исправляться

export HISTIGNORE="&:l:l[aslxkcurtm]:bg:fg:exit" # Это позволит избавиться от дубликатов в истории команд

shopt -s cmdhist # многострочные команды будут записываться в одну строку

umask 022

# eval "`dircolors`" # цветные файлы в ls

#-------------------------
# Псевдонимы
#-------------------------

export LS_OPTIONS='--color=always --human'

alias l='ls $LS_OPTIONS -hF'
alias ls='ls $LS_OPTIONS -hF'               # выделить различные типы файлов цветом
alias la='ls $LS_OPTIONS -Al'               # показать скрытые файлы
alias ll='ls $LS_OPTIONS -l'                # показать подробно
alias lx='ls $LS_OPTIONS -lXB'              # сортировка по расширению
alias lk='ls $LS_OPTIONS -lSr'              # сортировка по размеру
alias lc='ls $LS_OPTIONS -lcr'              # сортировка по времени изменения
alias lu='ls $LS_OPTIONS -lur'              # сортировка по времени последнего обращения
alias lr='ls $LS_OPTIONS -lR'               # рекурсивный обход подкаталогов
alias lt='ls $LS_OPTIONS -ltr'              # сортировка по дате
alias lm='ls $LS_OPTIONS -al | more'        # вывод через 'more'
alias tree='tree -Csu'                      # альтернатива 'ls'

alias e="extract"
alias drush="/usr/local/bin/drush"

#--------
# Prompt
#--------

PS1="\[${bldred}\]\u@\h:\[${NC}\]\[${bldblu}\]\w\[${NC}\]\$ "

#-----------
# Архиватор
#-----------

function extract()      # Handy Extract Program.
{
     if [ -f $1 ] ; then
         case $1 in
             *.tar.bz2)   tar xvjf $1     ;;
             *.tar.gz)    tar xvzf $1     ;;
             *.bz2)       bunzip2 $1      ;;
             *.rar)       unrar x $1      ;;
             *.gz)        gunzip $1       ;;
             *.tar)       tar xvf $1      ;;
             *.tbz2)      tar xvjf $1     ;;
             *.tgz)       tar xvzf $1     ;;
             *.zip)       unzip $1        ;;
             *.Z)         uncompress $1   ;;
             *.7z)        7z x $1         ;;
             *)           echo "'$1' cannot be extracted via >extract<" ;;
         esac
     else
         echo "'$1' is not a valid file"
     fi
}

