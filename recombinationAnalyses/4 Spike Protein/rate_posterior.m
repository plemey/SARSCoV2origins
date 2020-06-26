clear all;
A=load('patristic_distances.log');

% columns are
%
%  1 state
%  2 ctd_bat	
%  3 vl_bat	
%  4 ctd_pangolin	
%  5 vl_pangolin

str_titles={'CTD SARS2-RaTG13','VarLoop SARS2-RaTG13','CTD SARS2-Pangolin2019','VarLoop SARS2-Pangolin2019'};

% remove burn-in, first 10% of run
A = A(203:2002,:); 
nbins = floor( sqrt(size(A,1)) );
mediumgreen=[0.3 0.9 0.9];

for spi=1:4
    
        subplot(2,2,spi)
        c=spi+1;
        
        h=histfit( A(:,c), nbins, 'kernel' ); hold on;
        h(1).FaceColor = [.9 .9 .9];
        h(1).EdgeColor = [.9 .9 .9];
        
        qs = quantile( A(:,c), [.025 .25 .5 .75 .975] );
        %hpd_bnds = hpdi( A(:,c), 95 );

        h(2).Color = [.5 .5 .5];

        yytop = h(2).YData;
        yybot = zeros(1, size(yytop,2));
        xx = h(2).XData;
        h2=fill( [xx fliplr(xx)], [yytop fliplr(yybot)], mediumgreen); 
        set(h2,'facealpha',.2)
        
        title( str_titles{spi} );
        axis([0.0 1.1 0 200]);
        
        %xlabel( 'Fraction of Symp Cases Reported to Health System' );  

end

%%

figure;

h=histfit( A(:,2), nbins, 'kernel' ); hold on;
        h(1).FaceColor = [.99 .99 .99];
        h(1).EdgeColor = [.99 .99 .99];
        h(2).Color = [.9 .5 .5];
        yytop = h(2).YData; yytop1=yytop;
        yybot = zeros(1, size(yytop,2));
        xx = h(2).XData; xx1=xx;
        h2=fill( [xx fliplr(xx)], [yytop fliplr(yybot)], [255 255 204]/255); 
        set(h2,'facealpha',.5)

h3=histfit( A(:,3), nbins, 'kernel' ); hold on;
        h3(1).FaceColor = [.99 .99 .99];
        h3(1).EdgeColor = [.99 .99 .99];
        h3(2).Color = [.9 .5 .5];
        yytop = h3(2).YData; yytop2=yytop;
        yybot = zeros(1, size(yytop,2));
        xx = h3(2).XData; xx2=xx;
        h4=fill( [xx fliplr(xx)], [yytop fliplr(yybot)], [161 218 180]/255); 
        set(h4,'facealpha',.5);
        
h5=histfit( A(:,4), nbins, 'kernel' ); hold on;
        h5(1).FaceColor = [.99 .99 .99];
        h5(1).EdgeColor = [.99 .99 .99];
        h5(2).Color = [.9 .5 .5];
        yytop = h5(2).YData; yytop3=yytop;
        yybot = zeros(1, size(yytop,2));
        xx = h5(2).XData; xx3=xx;
        h6=fill( [xx fliplr(xx)], [yytop fliplr(yybot)], [65 182 196]/255); 
        set(h6,'facealpha',.5);

h7=histfit( A(:,5), nbins, 'kernel' ); hold on;
        h7(1).FaceColor = [.99 .99 .99];
        h7(1).EdgeColor = [.99 .99 .99];
        h7(2).Color = [.9 .5 .5];
        yytop = h7(2).YData; yytop4=yytop;
        yybot = zeros(1, size(yytop,2));
        xx = h7(2).XData; xx4=xx;
        h8=fill( [xx fliplr(xx)], [yytop fliplr(yybot)], [34 94 168]/255); 
        set(h8,'facealpha',.5);

 
%%


% export as 12" by 6", fixed font as 11


figure;
trans=0.25;
lw=1.5;

plot(xx1,yytop1,'k-', 'LineWidth', lw); hold on;
        yybot1 = zeros(1, size(yytop1,2));
        hh1=fill( [xx1 fliplr(xx1)], [yytop1 fliplr(yybot1)], [255 255 204]/255); 
        set(hh1,'facealpha',trans)

plot(xx2,yytop2,'k-', 'LineWidth', lw);
        yybot2 = zeros(1, size(yytop2,2));
        hh2=fill( [xx2 fliplr(xx2)], [yytop2 fliplr(yybot2)], [161 218 180]/255); 
        set(hh2,'facealpha',trans)

plot(xx3,yytop3,'k-', 'LineWidth', lw);
        yybot3 = zeros(1, size(yytop3,2));
        hh3=fill( [xx3 fliplr(xx3)], [yytop3 fliplr(yybot3)], [65 182 196]/255); 
        set(hh3,'facealpha',trans)

plot(xx4,yytop4,'k-', 'LineWidth', lw);
        yybot4 = zeros(1, size(yytop4,2));
        hh4=fill( [xx4 fliplr(xx4)], [yytop4 fliplr(yybot4)], [34 94 168]/255); 
        set(hh4,'facealpha',trans)
        
        
set(gca, 'YTick', []);
set(gca, 'XTick', 0.0:0.1:1.1);
axis([0 1.15 0 200]);
xlabel('SUBSTITUTIONS PER SITE');
box off; 
        
        
%%

z = hpdi( A(:,[2 3 4 5]), 95 )
        
        
        
        
        
        
