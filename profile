# ============================
# Configurações globais do mpkg
# ============================

# Diretórios do mpkg
export MPKG_STORY="$HOME/.mpkg/story"          # Pacotes compilados
export MPKG_PROFILE="$HOME/.mpkg/profile"     # Symlinks para versão ativa
export MPKG_SRC="$HOME/.mpkg/src"             # Diretório de trabalho (build)
export MPKG_LOG="$HOME/.mpkg/log"             # Logs de build/install
export MPKG_REPO="$HOME/.mpkg/repo"           # Repo git para sync

# Opções de mpkg
export MPKG_COLOR=1                            # Saída colorida (1 = ativado)
export MPKG_SPINNER=1                          # Spinner para progresso (1 = ativado)
export MPKG_FORCE=0                             # Forçar rebuild (0 = não, 1 = sim)

# Criar diretórios caso não existam
mkdir -p "$MPKG_STORY" "$MPKG_PROFILE/bin" "$MPKG_SRC" "$MPKG_LOG" "$MPKG_REPO"

# Adicionar diretórios do mpkg ao PATH e LD_LIBRARY_PATH
export PATH="$MPKG_PROFILE/bin:$PATH"
export LD_LIBRARY_PATH="$MPKG_PROFILE/lib:$LD_LIBRARY_PATH"

# ============================
# Funções auxiliares do mpkg
# ============================

# Ativar cores para mensagens
mpkg_color() {
    [[ $MPKG_COLOR -eq 1 ]] || return
    case $1 in
        red)    echo -e "\033[31m$2\033[0m" ;;
        green)  echo -e "\033[32m$2\033[0m" ;;
        yellow) echo -e "\033[33m$2\033[0m" ;;
        blue)   echo -e "\033[34m$2\033[0m" ;;
        *) echo "$2" ;;
    esac
}

# Função para spinner (progresso)
mpkg_spinner() {
    local pid=$1
    local i=0
    local sp="/-\|"
    while kill -0 $pid 2>/dev/null; do
        i=$(( (i+1) %4 ))
        printf "\r%s" "${sp:$i:1}"
        sleep .1
    done
    printf "\r"
}

# ============================
# Alias e atalhos para mpkg
# ============================

alias mpkgb='mpkg build'       # build
alias mpkgi='mpkg install'     # install
alias mpkgr='mpkg remove'      # remove
alias mpkgrb='mpkg rebuild'    # rebuild all
alias mpkgu='mpkg upgrade'     # upgrade
alias mpkgs='mpkg strip'       # strip
alias mpkgp='mpkg pack'        # pack
alias mpkgd='mpkg destdir'     # build em destdir/fakeroot
alias mpkgo='mpkg orphans'     # remover órfãos
alias mpkgy='mpkg sync'        # sync git
alias mpkgh='mpkg help'        # help completo

# ============================
# Mensagem de boas-vindas
# ============================
echo "MPKG carregado: diretórios configurados"
echo "STORY: $MPKG_STORY"
echo "PROFILE: $MPKG_PROFILE"
echo "SRC: $MPKG_SRC"
echo "LOG: $MPKG_LOG"
echo "REPO: $MPKG_REPO"
