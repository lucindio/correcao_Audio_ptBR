#!/bin/bash
versao="0.1"
clear
echo ""
echo ""
echo " _   _         _____ ______  _____                    "
echo '| | | |       |_   _|| ___ \'"|  ___|v$versao         "
echo '| | | |  ___    | |  | |_/ /| |__    __ _  ___  _   _ '
echo '| | | | / _ \   | |  |  __/ |  __|  / _` |/ __|| | | |'
echo '\ \_/ /| (_) | _| |_ | |    | |___ | (_| |\__ \| |_| |'
echo ' \___/  \___/  \___/ \_|    \____/  \__,_||___/ \__, |'
echo "                                                  _/ |"
echo "                                                 |__/ "
echo "======================================================"
echo ""
echo "Patch Brasileiro para Correção de Audios no FreePBX"
echo "Autor Luciano Cavalcante Souza - Empresa VoipEasy"
echo "Homologação Janduy Euclides - Empresa JP Soluções em TI"
echo "Credito Rafael Tavares - Empresa Ibinetwork Informática"
echo "https://www.voipeasy.com.br / 79 98814-5895"
echo "======================================================="
echo "           ..::  AÇÕES ::.. "
echo "Coreção dos audios:" 
echo "im-sorry.slin"
echo "an-error-has-occurred.ulaw"
echo "with.ulaw"
echo "call-forwarding.ulaw"  
echo ""
sleep 10
#clear

echo "--------------------------------------------------------"
echo "     Carregando variaveis de apoio                      "
echo "--------------------------------------------------------"
DIR="/var/lib/asterisk/sounds/pt_BR"
SORRY=$(ls -la $DIR/ | grep -c [i]m-sorry*)
OCCURRED=$(ls -la $DIR/ | grep -c [a]n-error-has-occurred)
OCCURED=$(ls -la $DIR/ | grep -c [a]n-error-has-occured)
WITCH=$(ls -la $DIR/[w]ith* |wc -l)
CALLFORWARDING=$(ls -la $DIR/[c]all-forwarding* |wc -l)

mkdir /var/log/voipeasy/
>/var/log/voipeasy/audio.log 
LOG="/var/log/voipeasy/audio.log"

#Funcao responsavel por gerar os logs
function log(){
        echo "[$(date +%b' '%d' '%H:%M:%S)] $1" >> $LOG
}

#Funcao responsavel por gerar log de erro
function log_erro(){
        if [ $? -gt 0 ]; then
                log "$1 - FALHOU"
        else
                log "$1 - OK"
        fi
}
sleep 2
#clear

echo "--------------------------------------------------------"
echo "   Verificando e Alterando arquivos im-sorry            "
echo "--------------------------------------------------------"

cd $DIR
if [ $SORRY -ge 1 ] 
then 
	log "Exite $SORRY no diretorio pt_BR"
	log "Estou renomenado todos eles im-sorry.xxxx.old"
	SORRY1=$(ls -la im-sorry* |awk '{print $9}')
	echo "$SORRY1" | while read line; 
	do 
	
		
		log_erro "$line"
		mv $line $line.old
		log_erro "Movendo arquivo de $line para $line.old"
	done
else	
log "Não existe arquivos im-sorry em pt_BR"
fi 
sleep 2
#clear

echo "--------------------------------------------------------"
echo " Verificando e Alterando arquivos an-error-has-occurred "
echo "--------------------------------------------------------"

cd $DIR
if [ $OCCURRED -ge 1 ]
then
        log "Exite $OCCURRED no diretorio pt_BR"
        log "Estou renomenado todos eles an-error-has-occurred.xxx.old"
        OCCURRED1=$(ls -la an-error-has-occurred* |awk '{print $9}')
        echo "$OCCURRED1" | while read line;
        do


                log_erro "$line"
                mv $line $line.old
                log_erro "Movendo arquivo de $line para $line.old"
        done
else
log "Não existe arquivos an-error-has-occurred em pt_BR"
fi
sleep 2
#clear

echo "--------------------------------------------------------"
echo " Verificando e Alterando arquivos an-error-has-occured "
echo "--------------------------------------------------------"

cd $DIR
if [ $OCCURED -ge 1 ]
then
        log "Exite $OCCURED no diretorio pt_BR"
        log "Estou renomenado todos eles an-error-has-occured.xxx.old"
        OCCURRED1=$(ls -la an-error-has-occured* |awk '{print $9}')
        echo "$OCCURED1" | while read line;
        do


                log_erro "$line"
                mv $line $line.old
                log_erro "Movendo arquivo de $line para $line.old"
        done
else
log "Não existe arquivos an-error-has-occured em pt_BR"
fi
sleep 2
#clear

echo "--------------------------------------------------------"
echo "   Verificando e Alterando arquivos with            "
echo "--------------------------------------------------------"

cd $DIR
if [ $WITH -ge 1 ]
then
        log "Exite $WITH no diretorio pt_BR"
        log "Estou renomenado todos eles with.xxxx.old"
        WITH1=$(ls -la with* |awk '{print $9}')
        echo "$WITH1" | while read line;
        do


                log_erro "$line"
                mv $line $line.old
                log_erro "Movendo arquivo de $line para $line.old"
        done
else
log "Não existe arquivos with em pt_BR"
fi
sleep 2
#clear

echo "--------------------------------------------------------"
echo "   Verificando e Alterando arquivos call-forwarding     "
echo "--------------------------------------------------------"

cd $DIR
if [ $CALLFORWARDING -ge 1 ]
then
        log "Exite $CALLFORWARDING no diretorio pt_BR"
        log "Estou renomenado todos eles call-forwarding.xxxx.old"
        CALLFORWARDING1=$(ls -la call-forwarding* |awk '{print $9}')
        echo "$CALLFORWARDING1" | while read line;
        do


                log_erro "$line"
                mv $line $line.old
                log_erro "Movendo arquivo de $line para $line.old"
        done
else
log "Não existe arquivos call-forwarding em pt_BR"
fi
sleep 2
#clear

echo "--------------------------------------------------------"
echo "   Baixando novos audios e colocando em pt_BR           "
echo "--------------------------------------------------------"

log "baixando os audios a serem alterados"
svn co https://github.com/lucindio/AudiosPtBr/trunk/ /usr/src/Audio_ptBR
log_erro "Criando diretorio /usr/src/Audio_ptBR"
echo ""
cd /usr/src/Audio_ptBR
rm -rf desktop.ini
echo ""
log "Colocandos audios baixados no diretorio pt_BR"
echo ""
rsync --progress -r -u /usr/src/Audio_ptBR $DIR
echo ""
amportal restart 
log "Serviço concluido"
sleep 2
#clear
echo "--------------------------------------------------------"
echo "   Serviço concluido           "
echo "--------------------------------------------------------"
