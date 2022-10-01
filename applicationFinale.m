function varargout = GUI_application(varargin)
clear all;
close all;

%****************************** aficher le titre**********************************
fig_pr=figure('name','Détection de contours','units','normalized','outerposition',[0.1 0.1 0.7 0.9],'color',[0.3 0.75 0.93]);


%******************* aficher le panel options*******************************
%dialog('name','Exemple de uipanel', 'windowstyle','normal')
fig_pr  = uipanel('title','', 'position',[.43 .166 .22 .50], ...
    'fontsize',16, 'backgroundcolor',[0.3 0.66 0.99]);


uicontrol(fig_pr,'string','Fermer', 'position',[20 17 80 30], ...
    'callback','close');   % bouton dans le sous-panel 1
uicontrol('style','text', 'string','Options', ...
    'units','normalized', 'position', [0.457 .63 0.15 0.07], ...
  'foregroundcolor', 'black', 'backgroundcolor',[0.93 0.69 0.13], ...
  'horizontalalignment','center',  ...
  'fontsize',16);
        

%**************************************aficher logo******************************************************************************
a=axes('units','normalized','position',[0.02 0.72614 0.95 0.29]);  
 a.XTickLabel = {}
 a.YTickLabel = {}
 imshow('applogo1.png');
 
 b=axes('units','normalized','position',[0.005109203 0.02103694 1.009955 0.13 ]);  
 b.XTickLabel = {}
 b.YTickLabel = {}
 imshow('applogo2.png');
 %+++++++++++++++++++ botonn pour insérer une image à filtrer dans l'axe 1 ****
 %%figure
R=uicontrol(  'units','normalized','style','ToggleButton','string',' Insérer image','fontname','andalus',...
            'Position', [0.09 0.63 0.09 0.07 ],'Backgroundcolor','yellow','FontWeight','bold','callback',@ouvrir_image);

%------------------------------- les deux axes pour aficher les images ----------------------
a(1)=axes('units','normalized','position',[0.019 0.19 0.23 0.4],'GridLineStyle','none','color','[0.83 0.92 0.96]');
a(1).XTickLabel = {}
a(1).YTickLabel = {};
a(2)=axes('units','normalized','position',[0.692 0.19 0.23 0.4],'GridLineStyle','none','color','[0.83 0.92 0.96]');
a(2).XTickLabel = {}
a(2).YTickLabel = {}

%**************************<<button utilisÃ©  pour visualiser l'image originale et button de retour et champs des valeurs de luminositÃ© *****

text_lum=uicontrol('units','normalized','style','text','string','Luminosité','Position', [0.2753 0.525 0.1 0.05],'value',0,...
    'FontWeight','bold','Backgroundcolor','[0 1 1]','fontname','andalus','callback',@ouvrir_image);
text_sl=uicontrol('units','normalized','style','text','fontname','Bodoni MT',...
            'Position', [0.2753 0.488 0.06 0.035],'Backgroundcolor','[0 1 1]','FontWeight','bold','callback',{@ec_fn,'m'});
k1=uicontrol(  'units','normalized','style','pushbutton','string','Image originale','fontname','andalus',...
            'Position', [0.2753 0.27 0.1 0.05],'Backgroundcolor','[0 1 1]','FontWeight','bold','callback',@color_img);
k2=uicontrol('units','normalized','style','pushbutton','string','annuler','fontname','andalus',...
            'Position', [0.2753 0.13 0.1 0.05],'Backgroundcolor','[0 1 1]','FontWeight','bold','callback',@ret);

        %******************<<le glissier de luminositÃ©>>***************************
slid_ec=uicontrol('units','normalized','style','slider',...
              'string','eclirage',...
              'Min' ,0,'Max',255,'sliderstep',[1/255 10/255],'Backgroundcolor','[1 1 1]', ...
              'Position', [0.336214285714286 0.26 0.039642857142857 0.262190476190476],...
              'Value',0,'callback',{@ec_fn,'ec'});
          
 %***********<<le menu pour choisir le type de contour>>***************
ctr(1)=uicontrol(fig_pr, 'style','popup','string','gradian|roberts|prewitt|laplacien|sobel|freishen|deriche|canny',...
            'Min',0,'Max',8,'Position', [103 221 87 20],'callback',{@choixtxt,'typecontour'});
        
text(1)=uicontrol(fig_pr,'style','text','string','Type de contour ','fontname','andalus','Position', [10 220 94 21],'Backgroundcolor','green');

%*********************le menu pour choisir le bruit***********************

ctr(10)=uicontrol(fig_pr,'units','normalized','style','popup','string','non|gaussian|poisson|salt&pepper',...
'Min',0,'Max',2,'Position', [.51 .5210 .42 .15],'callback',{@choixbruit,'typebruit'});
        
text(10)=uicontrol(fig_pr,'units','normalized','style','text','string','bruit ','fontname','andalus','Position',...
    [.045 .590 .47 .08],'Backgroundcolor','green');


%************************* affcher le choix de seuillage******************
 ctr(3)=uicontrol( fig_pr, 'style','popup','string','non|oui','Min',0,'Max',4,'Position',[106.500 136.870 82 19.5] ,'callback',{@choixseuil,'seuillage'});
 text(3)=uicontrol(fig_pr,  'style','text','string','seuillage','fontname','andalus','Position', [9.900 135.870 97 21],'Backgroundcolor','green');
 
 %************************ slider pour choisir le seuillage **************
 ctr(4)=uicontrol(fig_pr,'style','slider','string','seuil','Min' ,0,'Max',255,'Position', [106 108 82 20],'Value', 0,'SliderStep',[1/255 10/255], ...
             'callback',{@choix,'seuil'});
 text(4)=uicontrol( fig_pr, 'style','text','string','seuil','fontname','andalus','Position', [10.009900 108 97 20],'Backgroundcolor','green');
[106.500 136.870 82 19.5]
 
 %*************************  choisir le masque **************************
 ctr(20)=uicontrol(fig_pr,'style','popup','string','3x3|5x5','Position', [107 81 80 20],'callback',{@appliquer,'Masque'});
 text(20)=uicontrol(fig_pr,'style','text','string','Masque','fontname','andalus','Position', [9.900 78.870 97 21],'Backgroundcolor','green');
 
%***************** le boton Appliquer *************************************
 appl=uicontrol('units','normalized','style','pushbutton','string','appliquer','fontname','andalus','Backgroundcolor','[0 1 1]',...
     'FontWeight','bold','Position', [0.27493453 0.4 0.1 0.05],'callback',@appliquer);
 
 %*********le button pour affiche l'histogramme de l'image original*********
hist=uicontrol(  'units','normalized','style','pushbutton','string','histogramme','fontname','andalus','Backgroundcolor','[0 1 1]',...
    'FontWeight','bold','Position', [0.27493453 0.34 0.1 0.05],'callback',@gethist );

% **** les trois buttons supprimer quitter et ouvrir l'image dans le figure ************        
supp=uicontrol('units','normalized','style','pushbutton','string','supprimer','fontname','andalus','Backgroundcolor','[0 1 1]',...
    'FontWeight','bold','Position', [0.27493453 0.20 0.1 0.05],'callback',@supprimer );
uicontrol(  'units','normalized','style','pushbutton','string','ouvrir l''image dans le figure','fontname','andalus',...
    'Backgroundcolor','[0 1 1]','FontWeight','bold','Position', [0.70 0.615 0.2 0.05],'callback',{@fig_img,'im'});


%**********************************************************************************
%***********<<<<les buttons au cas de l'operateur de CANNY et Canny-deriche>>>>****
%**********************************************************************************


%******************** le paramétre sigma ****************************
ctr(6)=uicontrol( fig_pr, 'style','edit','string','1','Position', [106.500 136.870 82 19.5],'callback',{@choixnb1,'sigma'});
text(6)=uicontrol( fig_pr, 'style','text','string','sigma','fontname','andalus','Position', [9.900 135.870 97 21],'Backgroundcolor','red');
 
%****************le paramétre seuil bas  ************************
ctr(7)=uicontrol( fig_pr, 'style','edit','string','1','Position', [105.5 80 84 20],'callback',{@choixnb1,'lowTh'});
text(7)=uicontrol( fig_pr, 'style','text','string','tb','fontname','andalus','Position',  [10.945 79 95 21],'Backgroundcolor','red');

%***************** le paramétre seuil haut *********
ctr(8)=uicontrol( fig_pr, 'style','edit','string','0','Position',[106 108 82 20],'callback',{@choixnb1,'highTh'});
text(8)=uicontrol( fig_pr, 'style','text','string','th','fontname','andalus','Position', [10.009900 108 97 20],'Backgroundcolor','red');

 %******************** le paramétre alpha de deriche*********************************
ctr(9)=uicontrol(fig_pr,  'style','edit','string','1','Position',[106.500 136.870 82 19.5],'callback',{@choixnb,'alph'});
text(9)=uicontrol( fig_pr, 'style','text','string','alpha','fontname','andalus','Position', [9.900 135.870 97 21],'Backgroundcolor','blue');


 %**********************************************************************************************************************************
%**************************************************<<<LES PARAMETRES INITIAL>>>>>>*************************************************
%**********************************************************************************************************************************

%set(fig_pr,'position',[356 63 858 621]);
set(slid_ec,'Enable','off');
set(slid_ec,'Visible','off');
set(text_lum,'Visible','off');
set(text_lum,'Enable','off');
set(text_sl,'Visible','off');
set(text_sl,'Enable','off');
set(k2,'Enable','off');
set(k2,'Visible','off');
setappdata(gcf,'distance',1);
setappdata(gcf,'Masque','3x3');
setappdata(gcf,'seuillage','non');
setappdata(gcf,'seuil',0);
setappdata(gcf,'x',1);
setappdata(gcf,'typecontour','gradian');
setappdata(gcf,'n',10);
setappdata(gcf,'s',1);
setappdata(gcf,'theta_v',60);
setappdata(gcf,'theta_h',30);
set(ctr(20),'Enable','off');
set(ctr(20),'Visible','off');

set(ctr(6),'Enable','off');
set(ctr(6),'Visible','off');
set(ctr(7),'Enable','off');
set(ctr(7),'Visible','off');
set(ctr(8),'Enable','off');
set(ctr(8),'Visible','off');

set(text(6),'Enable','off');
set(text(6),'Visible','off');
set(text(7),'Enable','off');
set(text(7),'Visible','off');
set(text(8),'Enable','off');
set(text(8),'Visible','off');
set(text(9),'Enable','off');
set(text(9),'Visible','off');
set(ctr(9),'Enable','off');
set(ctr(9),'Visible','off');
set(text(20),'Enable','off');
set(text(20),'Visible','off');

 %**********************************************************************************************************************************
%**************************************************<<<LES FONCTIONS ASSOCIE A CHAQUE BT>>>>>>**************************************
%**********************************************************************************************************************************
   
    function color_img()
        global y;
          axes(a(1))
          imshow(y) 
        set(k1,'Enable','off');
        set(k1,'Visible','off');
        set(k2,'Enable','on');
        set(k2,'Visible','on');
        set(slid_ec,'Enable','on');
        set(slid_ec,'Visible','on');
        set(text_lum,'Visible','on');
        set(text_lum,'Enable','on');
        set(text_sl,'Visible','on');
        set(text_sl,'Enable','on');
        set(hist,'Enable','off');
        set(hist,'Visible','off');
        set(supp,'Enable','off');
        set(supp,'Visible','off');
        set(appl,'Enable','off');
        set(appl,'Visible','off');
    end
%********************la fnc pour visualiser l'image originale************
    function ret()
        global x;
        axes(a(1))
        imshow(x) 
        set(k2,'Enable','off');
        set(k2,'Visible','off');
        set(k1,'Enable','on');
        set(k1,'Visible','on');
        set(slid_ec,'Enable','off');
        set(slid_ec,'Visible','off');
        set(text_lum,'Visible','off');
        set(text_lum,'Enable','off');
        set(text_sl,'Visible','off');
        set(text_sl,'Enable','off');
        set(hist,'Enable','on');
        set(hist,'Visible','on');
        set(supp,'Enable','on');
        set(supp,'Visible','on');
        set(appl,'Enable','on');
        set(appl,'Visible','on');
    end
    %--------------------------------------------------------------------------------------------    
function ouvrir_image(y,x)
    [filename, pathname] = uigetfile({'*.jpg;*.tif;*.png;*.gif;*.bmp','All Image Files';'*.*','All Files' },'monimage','C:\Work\myfile.jpg')
     global y;
     global x;
    y= imread(filename);
   if (length(size(y))>1)
  
    x=y(:,:,1);% on prend un seul plan image noir et blanc les plans sont Ã©gaux
       end
set(text_name,'string',filename);
set(text_src,'string',pathname);

%      x=rgb2gray(y);
      k = whos('y');
%     if k.class == 'uint8'
%         k=8;
%     end
   setappdata(1,'k',k);
   setappdata(1,'x',x);
    axes(a(1))
    imshow(x) 
end
%*******************<<< la fnct associe au bouton ouvrir>>>*********************
%***************************************
%***************************************
function choixbruit(hObj,br,name)
    global x;
    global br;
    val_temp=x;%variable temporaire pour eviter la pert de l'image original aprÃ©s l'opÃ©ration de bruitage
    val = get(hObj,'Value');
%  typebruit = getappdata(1,'typebruit');
     if ( val == 0 ||val==1 )
         setappdata(1,name,'non');
         br=val_temp;
           setappdata(1,'x',x);
     elseif ( val == 2 )
         setappdata(1,name,'gaussian');
         br=imnoise(x,'gaussian');
           setappdata(1,'x',br);
     elseif ( val == 3 )
         setappdata(1,name,'poisson');
         br= imnoise(x,'poisson')
           setappdata(1,'x',br);
     elseif ( val == 4 )
         setappdata(1,name,'salt&pepper');
        br= imnoise(x,'salt & pepper')
          setappdata(1,'x',br);
     end 
    
    axes(a(1))
     imshow(br)
end
%************<<la fnct associe au btn bruit>>*******
%**************************************
%***************************************

    function ec_fn()
        global y;
        val=get(slid_ec,'value');
        deg=imadd(y,val);
        set(text_sl,'string',val );
        a(1);
        imshow(deg);
    end
% ************<<< la fnc associe au btn de luminositÃ©>>>*****************
    function supprimer(hobject, eventdata,handles)
cla(a(1),'reset')
cla(a(2),'reset')
set(text_name,'string','');
set(text_src,'string','');
a(1).XTickLabel = {}
a(1).YTickLabel = {}
a(2).XTickLabel = {}
a(2).YTickLabel = {}
    end

%***************<<< la fnc associe au btn fermer/quitter>>>*********************************
function gethist(hobject, eventdata,handles)
      h=getimage(a(1));
      j=figure('name','histogramme de l''image original','NumberTitle','off','menubar','none','toolbar','none','color','yellow');
      axes(a(2))
      imhist(h);
end
%********************<<< la fnc associe au btn histogramme>>>****************************
function fig_img(im, eventdata,handles)
global vglo;
 vglo=1;
  appliquer();
 vglo=0;
end

%***************<<< la fnc associe au menu type cnt>>>**********
function choixtxt(hObj,typecontour,name)
    % on l'appelÃ© quand l'utilisateur activÃ© le pop menu des contours
  
    val = get(hObj,'Value'); 
  
    set(ctr(3),'Enable','on');
    set(ctr(3),'Visible','on');
    set(ctr(4),'Enable','on');
    set(ctr(4),'Visible','on');
     set(ctr(20),'Enable','off');
    set(ctr(20),'Visible','off');
   
    set(text(3),'Enable','on');
    set(text(3),'Visible','on');
    set(text(4),'Enable','on');
    set(text(4),'Visible','on');
    
    set(ctr(6),'Enable','off');
    set(ctr(6),'Visible','off');
    set(ctr(7),'Enable','off');
    set(ctr(7),'Visible','off');
    set(ctr(8),'Enable','off');
    set(ctr(8),'Visible','off');
    set(ctr(9),'Enable','off');
    set(ctr(9),'Visible','off');
   
    set(text(6),'Enable','off');
    set(text(6),'Visible','off');
    set(text(7),'Enable','off');
    set(text(7),'Visible','off');
    set(text(8),'Enable','off');
    set(text(8),'Visible','off');
    set(text(9),'Enable','off');
    set(text(9),'Visible','off');
    set(text(20),'Enable','off');
    set(text(20),'Visible','off');
    if ( val == 0 || val == 1 )
        setappdata(1,name,'gradian');
         
    elseif ( val == 2 )
        setappdata(1,name,'roberts');
      
    elseif ( val == 3 )
        setappdata(1,name,'prewitt');
     
    elseif ( val == 5 )
        setappdata(1,name,'sobel');
       
        set(ctr(20),'Enable','on');
        set(ctr(20),'Visible','on');
         set(text(20),'Enable','on');
        set(text(20),'Visible','on');
    elseif ( val == 4 )
        setappdata(1,name,'laplacien');
        
    elseif ( val == 6 )
        setappdata(1,name,'freishen');
        set(text(2),'Visible','off');
         set(ctr(2),'Visible','off');
    elseif ( val == 8 )
        setappdata(1,name,'canny');
      
        set(ctr(6),'Enable','on');
        set(ctr(6),'Visible','on');
        set(ctr(7),'Enable','on');
        set(ctr(7),'Visible','on');
        set(ctr(8),'Enable','on');
        set(ctr(8),'Visible','on');
      
        set(text(6),'Enable','on');
        set(text(6),'Visible','on');
        set(text(7),'Enable','on');
        set(text(7),'Visible','on');
        set(text(8),'Enable','on');
        set(text(8),'Visible','on');
       
        set(ctr(3),'Enable','off');
        set(ctr(3),'Visible','off');
        set(ctr(4),'Enable','off');
        set(ctr(4),'Visible','off');
     
        set(text(3),'Enable','off');
        set(text(3),'Visible','off');
        set(text(4),'Enable','off');
        set(text(4),'Visible','off');
        set(ctr(9),'Enable','off');
        set(ctr(9),'Visible','off');
        set(text(9),'Enable','off');
        set(text(9),'Visible','off');
        set(text(20),'Enable','off');
        set(text(20),'Visible','off');
     elseif ( val == 7 )
        setappdata(1,name,'deriche');
        set(text(9),'Enable','on');
        set(text(9),'Visible','on');
        set(ctr(9),'Enable','on');
        set(ctr(9),'Visible','on');
        
        set(ctr(6),'Enable','off');
        set(ctr(6),'Visible','off');
        set(ctr(7),'Enable','off');
        set(ctr(7),'Visible','off');
        set(ctr(8),'Enable','off');
        set(ctr(8),'Visible','off');
      
        set(text(6),'Enable','off');
        set(text(6),'Visible','off');
        set(text(7),'Enable','off');
        set(text(7),'Visible','off');
        set(text(8),'Enable','off');
        set(text(8),'Visible','off');
       
        set(ctr(3),'Enable','off');
        set(ctr(3),'Visible','off');
        set(ctr(4),'Enable','off');
        set(ctr(4),'Visible','off');
       
        set(text(3),'Enable','off');
        set(text(3),'Visible','off');
        set(text(4),'Enable','off');
        set(text(4),'Visible','off');
        set(text(20),'Enable','off');
        set(text(20),'Visible','off');
end
end
 
%************<<< la fnc associe au menu seuillage?>>>********
function choixseuil(hObj,seuillage,name)
    % on l'appelÃ© quand l'utilisateur active popup menu de seuillage
    val = get(hObj,'Value'); 
    if ( val == 0 || val == 1 )
        setappdata(1,name,'non');
    elseif ( val == 2 )
        setappdata(1,name,'oui');
    end
end

%************la fnc associe au sld de seuil>>>**************
function choix(hObj,seuil,Name)
    % on l'appelÃ© quand l'utilisateur varier la valeur de slider
    val = get(hObj,'Value'); 
    setappdata(1,Name,val);
    if(strcmp(Name,'seuil'))
        val=round(val);
        setappdata(1,Name,val);
        set( text(4), 'string' , strcat('seuil=',num2str(val)));
    end
end



   


function appliquer(hObj,sigma,lowTh,highTh,Masque,name)
    global x;
   
     typecontour = getappdata(1,'typecontour');
   
   
       img = double(getappdata(1,'x'));
     [ligne colonne]=size(img);
     img2=zeros(ligne,colonne); % creation d'une fond noirs (img2)
     img = double(getappdata(1,'x'));
     [ligne colonne]=size(img);
     img2=zeros(ligne,colonne); % creation d'une fond noirs (img2)
     %:::::::::::::application des masques selon le tye de dÃ©tecteur::::: 
     if (strcmp(typecontour,'gradian'))
         for i = 1:ligne-1
             for j = 1:colonne-1
                 img2(i,j) = ((img(i,j)-img(i,j+1))^2 + (img(i,j)-img(i+1,j))^2)^0.5;
             end
         end
    
     elseif (strcmp(typecontour,'roberts'))
         for i = 1:ligne-1
             for j = 1:colonne-1
                 img2(i,j) = (abs((img(i,j)-img(i+1,j+1)) + (img(i+1,j)-img(i,j+1))))/2;
             end
         end
     elseif (strcmp(typecontour,'prewitt'))
         for i = 1:ligne-2
             for j = 1:colonne-2
                 img2(i,j) = abs( (-img(i,j)-img(i+1,j)-img(i+2,j)+img(i,j+1)+img(i+1,j+1)+img(i+2,j+1))+...
                     (-img(i,j)-img(i,j+1)-img(i,j+2)+img(i+1,j)+img(i+1,j+1)+img(i+1,j+2)));
             end
         end
     elseif (strcmp(typecontour,'sobel'))
         masque=getappdata(1,'Masque');
                if(masque =='3x3')
                    for i = 1:ligne-2
                    for j = 1:colonne-2
                     img2(i,j) = abs( (-img(i,j)-2*img(i+1,j)-img(i+2,j)+img(i,j+1)+2*img(i+1,j+1)+img(i+2,j+1))+...
                     (-img(i,j)-img(i,j+1)-2*img(i,j+2)+img(i+1,j)+2*img(i+1,j+1)+img(i+1,j+2)));
                    end
                    end
                
                else(masque=='5x5')
                   img = double(img);
                    m = zeros(Ax, Ay); 
                   [Ax Ay  ] = size(img);
                           for i = 1:(Ax-1)
                           for j = 1:(Ay-1)
                           gx =  src(i, j) + src(i+1, j) - src(i, j+1)  - src(i+1, j+1);
                           gy = -src(i, j) + src(i+1, j) - src(i, j+1) + src(i+1, j+1);
                           img2(i,j) = (gx^2+gy^2)^0.5 ;
                           end
                           end
                    end
       
     elseif (strcmp(typecontour,'laplacien'))
         for i = 1:ligne-2
             for j = 1:colonne-2
                 img2(i,j) = img(i+1,j)+img(i,j)-4*img(i+1,j+1)+img(i+2,j+2)+img(i+1,j+1) ;
             end
         end
     
     elseif (strcmp(typecontour,'freishen'))
         for i = 1:ligne-2
             for j = 1:colonne-2
                  img2(i,j) = abs( (1/(2+sqrt(2)))*(-img(i,j)-sqrt(2)*img(i+1,j)-img(i+2,j)+img(i,j+1)+sqrt(2)*img(i+1,j+1)+img(i+2,j+1))+...
                     (1/(2+sqrt(2)))*(-img(i,j)-img(i,j+1)-sqrt(2)*img(i,j+2)+img(i+1,j)+sqrt(2)*img(i+1,j+1)+img(i+1,j+2)));
             end
         end
%*********************************************************************************************************************************        
      
     elseif (strcmp(typecontour,'canny'))
         n=1;
       
         
        

 
imgsrc =img;
[x, y, dim] = size(imgsrc);
 
 % Convertir l'image en  grayscale
if dim>1
    imgsrc = rgb2gray(imgsrc);
end
 
sigma = 1;
gausFilter = fspecial('gaussian', [3,3], sigma);
img= imfilter(imgsrc, gausFilter, 'replicate');
 
zz = double(img);
 
 %----------------------------------------------------------
 

 lowTh=30;
 
 src=imgsrc;
 
[Ax Ay dim ] = size(src);
 % Converted to grayscale
if dim>1
    src = rgb2gray(src);
end
 
 
src = double(src);
m = zeros(Ax, Ay); 
theta = zeros(Ax, Ay);
sector = zeros(Ax, Ay);
 canny1 = zeros(Ax, Ay);% non-maximum suppression
 canny2 = zeros(Ax, Ay);% hysteresis
bin = zeros(Ax, Ay);
for x = 1:(Ax-1)
    for y = 1:(Ay-1)
        gx =  src(x, y) + src(x+1, y) - src(x, y+1)  - src(x+1, y+1);
        gy = -src(x, y) + src(x+1, y) - src(x, y+1) + src(x+1, y+1);
        m(x,y) = (gx^2+gy^2)^0.5 ;
        %--------------------------------
        theta(x,y) = atand(gy/gx)  ;
        tem = theta(x,y);
        %--------------------------------
        if (tem<67.5)&&(tem>22.5)
            sector(x,y) =  0;    
        elseif (tem<22.5)&&(tem>-22.5)
            sector(x,y) =  3;    
        elseif (tem<-22.5)&&(tem>-67.5)
            sector(x,y) =   2;    
        else
            sector(x,y) =   1;    
        end
        %--------------------------------        
    end    
end

for y = 2:(Ax-1)
    for x = 2:(Ay-1)        
                 if 0 == sector(x,y)
            if ( m(x,y)>m(x-1,y+1) )&&( m(x,y)>m(x+1,y-1)  )
                canny1(x,y) = m(x,y);
            else
                canny1(x,y) = 0;
            end
                 elseif 1 == sector(x,y)
            if ( m(x,y)>m(x-1,y) )&&( m(x,y)>m(x+1,y)  )
                canny1(x,y) = m(x,y);
            else
                canny1(x,y) = 0;
            end
                 elseif 2 == sector(x,y)
            if ( m(x,y)>m(x-1,y-1) )&&( m(x,y)>m(x+1,y+1)  )
                canny1(x,y) = m(x,y);
            else
                canny1(x,y) = 0;
            end
                 elseif 3 == sector(x,y)
            if ( m(x,y)>m(x,y+1) )&&( m(x,y)>m(x,y-1)  )
                canny1(x,y) = m(x,y);
            else
                canny1(x,y) = 0;
            end
        end        
    end%end for y
end%end for x
 
%---------------------------------
 

for y = 2:(Ax-1)
    for x = 2:(Ay-1)        
                 if canny1(x,y)<lowTh
            canny2(x,y) = 0;
            bin(x,y) = 0;
            continue;
                 elseif canny1(x,y)>highTh
            canny2(x,y) = canny1(x,y);
            bin(x,y) = 1;
            continue;
                 Else
            tem =[canny1(x-1,y-1), canny1(x-1,y), canny1(x-1,y+1);
                       canny1(x,y-1),    canny1(x,y),   canny1(x,y+1);
                       canny1(x+1,y-1), canny1(x+1,y), canny1(x+1,y+1)];
            temMax = max(tem);
            if temMax(1) > ratio*lowTh
                canny2(x,y) = temMax(1);
                bin(x,y) = 1;
                continue;
            else
                canny2(x,y) = 0;
                bin(x,y) = 0;
                continue;
            end
        end
    end%end for y
end%end for x
 img2=uint8(canny2);
                
           
      elseif (strcmp(typecontour,'deriche'))
%  alpha=getappdata(1,'alph')   
       alpha=1;
       c=((1-exp(-alpha)).*(1-exp(-alpha)))/(exp(-alpha));
       k=(((1-exp(-alpha)).*(1-exp(-alpha))).*(alpha).*(alpha))/(1-2.*alpha.*exp(-alpha)-exp(-2.*alpha));
       [m,n]=meshgrid(-20:1:20,-20:1:20);
       X=(-c).*(m).*exp(-(alpha).*(abs(m)+abs(n))).*k.*(alpha.*(abs(n)+1));
       Y=(-c).*(n).*exp(-(alpha).*(abs(m)+abs(n))).*k.*(alpha.*(abs(m)+1));
       X=X./(alpha.*alpha);
       Y=Y./(alpha.*alpha);
     fronthor= conv2(img,X,'same');
     frontvert= conv2(img,Y,'same');
         contour=sqrt(frontvert.*frontvert+fronthor.*fronthor);
         % **************************
         alfa=0.1;
         contour_max=max(max(contour));
         contour_min=min(min(contour));
         seuil=alfa*(contour_max-contour_min)+contour_min;
         seuillage=contour;
         seuillage(seuillage<seuil) = seuil;
      
         
         
         [n,m]=size(seuillage);
         X=[-1,0,+1;-1,0,+1;-1,0,+1];
             Y=[-1,-1,-1;0,0,0;+1,+1,+1];
         
         for i=1:n-2,
             for j=1:m-2,
                 if seuillage(i+1,j+1) > seuil,
                 Z=seuillage(i:i+2,j:j+2);

                 XI=[frontvert(i+1,j+1)/contour(i+1,j+1), -frontvert(i+1,j+1)/contour(i+1,j+1)];
                 YI=[fronthor(i+1,j+1)/contour(i+1,j+1), -fronthor(i+1,j+1)/contour(i+1,j+1)];
                 
                 ZI=interp2(X,Y,Z,XI,YI);
                 
                     if seuillage(i+1,j+1) >= ZI(1) && seuillage(i+1,j+1) >= ZI(2)
                     contour_final(i,j)=contour_max;
                     else
                     contour_final(i,j)=contour_min;
                     end
                 else
                 contour_final(i,j)=contour_min;
                 end
             end
         end
         img2=contour_final;
         
     end
     

   
     %********<<seuillage par la methode fixe>>***************
     seuillage = getappdata(1,'seuillage');
     if (strcmp(typecontour,'canny') == 0)
         if strcmp(seuillage,'oui')
             img2 = uint8(img2);
             seuil = getappdata(1,'seuil');
             img2(img2<seuil) = 0;
             img2(img2>=seuil) = 255;
         end
     end
     axes(a(2))
     imshow(img2,[min(min(img2)) max(max(img2))]) % affichage de rÃ©sultat final 
     %------------------------------------------------------------------------------------------------------
     global vglo;
     if (vglo==1)
       fi=figure('name','image filtre','NumberTitle','off','color','yellow');
       set(fi,'position',[356 63 858 621]);
       imshow(img2,[min(min(img2)) max(max(img2))])
     end
     %-----------------------------<< ce code est depend de la fonction fig_img() -----------------------------------------------------------



end 
 
 

text_name=uicontrol('units','normalized','style','text','Position', [0.175 0.16 0.25 0.03],'value',0,'FontWeight','bold',...
   'fontname','andalus','callback',@ouvrir_image);
text_src=uicontrol('units','normalized','style','text','Position', [0.175 0.125 0.25 0.03],'value',0,'FontWeight','bold',...
    'fontname','andalus','callback',@ouvrir_image);
set(text_name,'visible','off');
set(text_src,'visible','off');
%****************************


end