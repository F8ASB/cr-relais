whiptail --title "Carnet de Bord Relais F1ZBV" --msgbox " Entrez la date, les intervenants et le contenu de l'intervention. Vous pourrez également visualisez les interventions précédentes. Ok pour continuer" 15 60

while : ; do

choix=$(whiptail --title "Choisir votre action" --radiolist \
"Que voulez vous faire ?" 15 50 4 \
"1" "Ecrire votre compte-rendu " ON \
"2" "Lire les derniers compte-rendu " OFF 3>&1 1>&2 2>&3)

exitstatus=$?

if [ $exitstatus = 0 ]; then
    echo "Choix:" $choix
else
    echo "Annulation"; break;
fi

Saisie_Date()
{
  Date=$(dialog --calendar calendrier 4 40)
if [ $exitstatus = 0 ]; then
    echo $Date
    Liste_Intervenants
else
    echo "Vous avez annulé"
fi
}

Liste_Intervenants()
{
intervenants=$(whiptail --title "Compte rendu intervention Relai F1ZBV" --checklist \
"Intervenants ?" 15 60 4 \
"F5FIM" "Jean-Paul" ON \
"F8ASB" "Juan" OFF \
"F4BKE" "Jean" OFF \
"F8DSN" "Damien" OFF 3>&1 1>&2 2>&3)
exitstatus=$?
if [ $exitstatus = 0 ]; then
    Intervention

else
    echo "Vous avez annulé"
fi
}

Intervention()

{
Inter=$(dialog --inputbox "Description de l'intervention?" 8 39 --title "Description" 3>&1 1>&2 2>&3)

exitstatus=$?
if [ $exitstatus = 0 ]; then
    echo "Description " $Inter
    Ecriture_fichier
else
    echo "User selected Cancel."
fi
}


Ecriture_fichier()

{
echo  $Date >> log.txt
echo  $Inter >> log.txt
echo  $intervenants|tr -d '"' >> log.txt
echo  "-+-----------------------------+-" >> log.txt
}


case $choix in

1) 
Saisie_Date
;;

2) 
pkill spotnik2hmi
ecrituredra
;;

esac


done
exit 0








