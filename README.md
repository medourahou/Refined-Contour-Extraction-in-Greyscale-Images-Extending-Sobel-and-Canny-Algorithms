# Refined Contour Extraction in Greyscale Images: Extending Sobel's and Canny's Algorithms
This project aims to extend Sobel and Canny's algorithms for edge detection in a grayscale image. 
<h2>Le filtre de Sobel</h2>
The Sobel filter (operator) is a tool used in image processing for edge detection, developed by <b>Sobel-Feldman</b> in 1968. The operator is based on gradient calculation of the intensity of each image pixel, this indicates the direction of greatest change from light to dark (contrast change), but also the rate of change in this direction.<br>
The operator uses convolution matrices. The matrix is (usually of size 3x3 but in our case we will work with 5x5) convolved with the image to calculate approximations of the two derivatives.

<h2>Le filtre de Canny</h2>
The Canny filter is used to determine edge detection. The algorithm was designed by John Canny in 1986 to be optimal over the following three constraints:<br>
<b>- Effective Detection:</b> This criterion involves seeking a detection operator that maximizes the signal-to-noise ratio, resulting in a low error rate in contour detection.

<b>- Accurate Localization:</b> This criterion aims to minimize the variance in the position of zero-crossings, leading to enhanced localization of contours.

<b>- Uniqueness of Response:</b> This criterion ensures a limited number of local maxima, striving to provide a single response per contour and avoid false positives.

<h2>L'utilisation de code</h2>
Pour exécuter le code il suffit juste de télécharger le fichier <i>applicationfinale.m</i> puis l'exécuter dans Matlab. 
