clc, clear
%CLJ16 Oil Future Options
%import CLJ16 options data
fileID = fopen('CLJ.txt');   
C = textscan(fileID,'%f %f %f %f');
fclose(fileID);

%1st column--strike price of CLJ16; 
%2nd column--market price; 
%3rd column--estimated price under heston-jumps model;
%4th column--estimated price under heston model
strike1=C{1};  
actual1=C{2};
jump1=C{3};
heston1=C{4};

%plot prices (market prices--black; jumps prices--red; heston prices--blue)
figure
plot(strike1,actual1,'k')
hold on;
plot(strike1,jump1,'r')
hold on;
plot(strike1,heston1,'b')
ylabel('Option Price($)') % label for y axis
xlabel('Strike Price($)') % label for x axis
legend('actual','jump','heston')
%print -depsc CLJ.eps


%err11--SSE between market prices and jumps prices
%err21--SSE between market prices and heston prices
err11=sum((actual1(:)-jump1(:)).^2)
err21=sum((actual1(:)-heston1(:)).^2)




%CLM16 Oil Future Options
%import CLJ16 options data
fileID = fopen('CLM.txt');
D = textscan(fileID,'%f %f %f %f');
fclose(fileID);
%1st column--market price of CLM16; 
%2nd column--estimated price under heston-jumps model;
%3rd column--estimated price under heston model;
%4th column--strike price
actual2=D{1};
jump2=D{2};
heston2=D{3};
strike2=D{4};

%plot prices (market prices--black; jumps prices--red; heston prices--blue)
figure
plot(strike2,actual2,'k')
hold on;
plot(strike2,jump2,'r')
hold on;
plot(strike2,heston2,'b')
ylabel('Option Price($)') % label for y axis
xlabel('Strike Price($)') % label for x axis
legend('actual','jump','heston')
%print -depsc CLM.eps


%err12--SSE between market prices and jumps prices
%err22--SSE between market prices and heston prices
err12=sum((actual2(:)-jump2(:)).^2)
err22=sum((actual2(:)-heston2(:)).^2)




