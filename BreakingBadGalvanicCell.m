clc;clear;

fprintf('Which Anode to use? \nAluminmum (Al) or Mercury (Hg2)\n')
Anode = input('','s');

if strcmp(Anode,'Al') || strcmp(Anode,'Aluminum')
    %Using Anode: aluminum, Cathode: Mercury as the cathode
    cathode = 1.66;
    anode = 0.85;
    Estnd = cathode+anode;
    R = 8.314;
    T = 43.5+273.15;
    n = 6;
    F = 96500;
    Q = [5*10^-9:0.01:2];
    cells = input('How many battery cells? ');
    E = cell([1 cells]);

    maxVolts = Estnd*cells - R*T/n*F*log(1);
    fprintf('Maximum voltage at equilibrium with %d cells: %.3f volts \n',cells,maxVolts);
    displayGraphs = input('Display graphs? (press any key): ');

    for ii = 1:1:cells
        Estnd2 = Estnd*ii;
        E{ii} = Estnd2 - (R*T)/(n*F)*log(Q); %calculate potential
        subplot(cells/2,2,ii)
        plot(Q,E{ii},'r')
            num = sprintf('%d cell(s)',ii);
            title(num)
            xlabel('Q')
            ylabel('Potential')
    end
elseif strcmp(Anode,'Hg2') || strcmp(Anode,'Mercury')
    %using zinc as the anode and mercury as the cathode
    clc;clear;
    Estnd = 1.61;
    R = 8.314;
    T = 83.5+273.15;
    n = 2;
    F = 96500;
    Q = [5*10^-9:0.01:2];
    cells = 10;
    for ii = 1:1:cells
        Estnd2=Estnd*ii
        E{ii} = Estnd2 - (R*T)/(n*F)*log(Q); %calculate potential
        subplot(cells/2,2,ii)
        plot(Q,E{ii},'r')
            num = sprintf('%d cell(s)',ii);
            title(num)
            xlabel('Q')
            ylabel('Potential')
    end
else
    return
end