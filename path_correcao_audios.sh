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
echo ""
echo "--------------------------------------------------------"
echo "     Carregando variaveis de apoio                      "
echo "--------------------------------------------------------"
DIR="/var/lib/asterisk/sounds/pt_BR"
echo "--------------------------------------------------------"
echo "   Baixando novos audios e colocando em pt_BR           "
echo "--------------------------------------------------------"
echo ""
svn co https://github.com/lucindio/AudiosPtBr/trunk/ /usr/src/Audio_ptBR
echo ""
cd /usr/src/Audio_ptBR
echo ""
echo ""
rsync -avzhe * $DIR
echo ""
sleep 2
#clear
echo "--------------------------------------------------------"
echo "   Serviço concluido           "
echo "--------------------------------------------------------"
