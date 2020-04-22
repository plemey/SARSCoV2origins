A=csvread('att01.bp.histogram.csv',1,0);

% 30927 is the correct sequence length
%
% 68 sequences in the alignment

%%

%plot( A(:,1), A(:,2), 'k-' );
%mx=1+max( A(:,2) );
%set(gca,'XTick', 4000:4000:28000);
%set(gca,'XTickLabel', {'4000','8000','12000','16000','20000','24000','28000'});
%set(gca,'TickDir','out');
%axis([0 30927 0 mx]);


%%

% export as 11" by 3", 11-point font

figure;
area( A(:,2), 'FaceColor', 'k' ); hold on;
alpha(1);
mx=1+max( A(:,2) );
set(gca,'XTick', 4000:4000:28000);
set(gca,'XTickLabel', {'4000','8000','12000','16000','20000','24000','28000'});
set(gca,'YTick', 68*[.05 .10 .15 .20]);
set(gca,'YTickLabel', {'5%','10%','15%','20%'});
set(gca,'TickDir','out');
axis([0 30927 0 mx]);
xlabel('Genome Position');
ylabel({'Percentage of Sequences','Supporting Breakpoint Position'});


ORFS=[276 13648
      13649 21747;
      21777 25769;
      25779 26609;
      26634 26864;
      26915 27601;
      27612 27798;
      28336 28707;
      28845 29272;
      29287 30555;
      30582 30698;
      23163 23444]; % this last one is the variable loop region

numorfs=size(ORFS,1);

lightgreen=[0.6 1.0 0.8];
lightpurple=[0.9 0.5 0.9];

for i=1:numorfs

    % offset
    os = mod(i,2); % this is either 0 or 1
    os2=os*0.8;
    
    x1=ORFS(i,1) ;x2=ORFS(i,2);
    y1=10.5+os2;y2=11.8+os2;
    
    thiscolor=lightgreen;
    if os==0
       thiscolor=lightpurple; 
    end
    
    xx=[x1 x2];
    fill([xx fliplr(xx)], [y2 y2 y1 y1], thiscolor,'LineStyle','none'); 
    
    
end



% x1=21777;x2=21777+3990;
% y1=10.5;y2=12;
% lightgreen=[0.6 1.0 0.8];
% lightpurple=[0.6 0.0 0.6];

% xx=[x1 x2];
% fill([xx fliplr(xx)], [y2 y2 y1 y1], lightgreen,'LineStyle','none'); 
%plot( xx,[y1 y1], '-', 'Color', lightgreen );
%plot( xx,[y2 y2], '-', 'Color', lightgreen );
%plot( [x1 x1],[y1 y2], '-', 'Color', lightgreen );
%plot( [x2 x2],[y1 y2], '-', 'Color', lightgreen );
alpha(0.50)


% BELOW WE HAVE THE VARIABLE LOOP REGION IN THE SPIKE PROTEIN
%
% x1=23163;x2=x1+281;
% y1=11.5;y2=12.5;
% 
% xx=[x1 x2];
% fill([xx fliplr(xx)], [y2 y2 y1 y1], lightpurple,'LineStyle','none'); 
alpha(0.50)



%%


% export as 13" by 7", 11-point font

fg = figure(1);
fg.Renderer='Painters'; % this ensures that the figure renders as vector;
                        % if you don't force this, Matlab will sometimes
                        % switch to raster if there are too many elements
                        % in the figure
subplot(2,1,1)


%y1=0.205; y2=0.995;
%xx=[21777 25769];

%plot( B(:,1), 1-B(:,2), 'Color', [0.6 0 0] ); hold on;
%fill([xx fliplr(xx)], [y2 y2 y1 y1], [0.94 0.96 0.94],'LineStyle','none'); 


area( A(:,2), 'FaceColor', 'k' ); hold on;
alpha(1);
mx=1+max( A(:,2) );
set(gca,'XTick', 4000:4000:28000);
set(gca,'XTickLabel', {'4000','8000','12000','16000','20000','24000','28000'});
set(gca,'YTick', 68*[.05 .10 .15 .20]);
set(gca,'YTickLabel', {'5%','10%','15%','20%'});
set(gca,'TickDir','out');
axis([0 30927 0 mx]);

ylabel({'Percentage of Sequences','Supporting Breakpoint Position'});


ORFS=[3625 9150; % this is BFR B
      9261 11795; % this is BFR C
      13291 14932;
      15405 17162;
      18009 19628]; % the last three are A prime

numorfs=size(ORFS,1);

lightgreen=[0.6 1.0 0.8];
lightpurple=[0.9 0.5 0.9];
lightorange=[255,200,124]/255;

for i=1:numorfs

    % offset
    %os = mod(i,2); % this is either 0 or 1
    %os2=os*0.8;
    os2=-4;
    
    x1=ORFS(i,1) ;x2=ORFS(i,2);
    y1=10.5+os2;y2=11.8+os2;
        
    if i==1
       thiscolor=lightpurple; 
    end
    if i==2
       thiscolor=lightgreen; 
    end
    if i>2
       thiscolor=lightorange; 
    end
    
    xx=[x1 x2];
    fill([xx fliplr(xx)], [y2 y2 y1 y1], thiscolor,'LineStyle','none'); 
    
    
end

alpha(0.50)

subplot(2,1,2)

B = load('dist_to_SARS2.tdl');

y1=0.205; y2=0.995;
xx=[21777 25769];

plot( B(:,1), 1-B(:,2), 'Color', [0.6 0 0] ); hold on;
fill([xx fliplr(xx)], [y2 y2 y1 y1], [0.94 0.96 0.94],'LineStyle','none'); 
plot( B(:,1), 1-B(:,9), 'Color', [0 0 0]/255, 'LineWidth', 2 ); % RaTG13

plot( B(:,1), 1-B(:,2), 'Color', [0.6 0 0] ); hold on; % CoVZC45|Bat-R_sinicus
plot( B(:,1), 1-B(:,3), 'Color', [0.8 0.1 0.1] ); % CoVZXC21|Bat-R_sinicus
plot( B(:,1), 1-B(:,4), 'Color', [0.2 0.1 0.8] ); %HKU3-1|Bat-R_sinicus
plot( B(:,1), 1-B(:,6), 'Color', [0.2 0.1 0.6] ); % Longquan_140|Bat-R_monoceros

plot( B(:,1), 1-B(:,5), 'Color', [255 105 180]/255 ); % this is SARS

plot( B(:,1), 1-B(:,7), 'Color', [255 140 0]/255 ); % these two are pangolin; P1E|pangolin
plot( B(:,1), 1-B(:,8), 'Color', [255 180 0]/255 ); % Pangolin-CoV|pangolin





set(gca,'XTick', 4000:4000:28000);
set(gca,'XTickLabel', {'4000','8000','12000','16000','20000','24000','28000'});
xlabel('Genome Position');
ylabel({'Similarity to','SARS-CoV-2'});

axis([0 30927 0.2 1]);


