# Sobel-Canny-algorithms-development
This project aims to extends the algorithms of sobel al and Canny for edge detection in a grayscale image. 
<h2>Le filtre de Sobel</h2>
Le filtre (l’opérateur) de Sobel est un outil utilisé en traitement d’image pour la détection de contours, réalisé par <b>Sobel-Feldman</b> en 1968.L’opérateur est basé sur le calcul de gradient de l’intensité de chaque pixel d’image, ceci indique la direction de la plus forte variation du clair au sombre (variation de contraste), mais aussi le taux de changement dans cette direction.<br>
L’opérateur utilise des matrices de convolution. La matrice est (généralement de taille 3x3 mais dans notre cas en va travailler avec 5x5) subit une convolution avec l’image pour calculer des approximations des deux dérivées.

<h2>Le filtre de Canny</h2>
Le filtre de Canny permet de déterminer la détection des contours. L’algorithme a été conçu par <b>John Canny</b> en 1986 pour être optimal sur trois contraints suivant :<br>
<b>- Bonne détection :</b>Cette critère revient à chercher un opérateur de détection et tel que le rapport signal sur le bruit soit maximum. C’est-à-dire faible taux d’erreur dans la signalisation des contours.<br>
<b>- Bonne localisation :</b>Cette critère corresponds la minimisation de variance de la position des passages par zéro et revient à maximiser la localisation.<br>
<b> - Unicité de la réponse :</b> Cette critère correspond à la limitation du nombre de maximas locaux. Il essaye de donner une seule réponse par contour et pas de faux positifs.

<h2>L'utilisation de code</h2>
Pour exécuter le code il suffit juste de télécharger le fichier <i>applicationfinale.m</i> puis l'exécuter dans Matlab. 
