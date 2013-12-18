


function app3

    file_name = 'app3.m';
    disp(['Starting' file_name]);

    function a = rectpos
        %
        % draw a rectangle
        %
        x = [0 0 1 1]';
        y = [0 1 1 0]';
        z = [1 1 1 1]';
        o = [1 1 1 1]';
        a = [x,y,z,o];
        hold on
        %
    end

    function a = trappos
        %
        % draw a trapezoid
        %
        x = [0 0 0.5 1 1]';
        y = [0 1 1.5 1 0]';
        z = [1 1 1 1 1]';
        o = [1 1 1 1 1]';
        a = [x,y,z,o];
        hold on
        %
    end


    function h = rect(a,c)
        %
        % draw a rectangle
        %
        x = a(:,1);
        y = a(:,2);
        z = a(:,3);
        fill3(x,y,z,c)
        hold on
        %
    end

    function h = trap(a,c)
        %
        % draw a trapezoid
        %
        x = a(:,1);
        y = a(:,2);
        z = a(:,3);
        fill3(x,y,z,c)
        hold on
        %
    end

    %Rotate object about y-axis
    function A = yrotate(angle, A)
        M = [ cos(angle) 0 -sin(angle) 0; 0 1 0 0; sin(angle) 0 cos(angle) 0; 0 0 0 1];
        A = A*M;
    end

    %Rotate object about x-axis
    function A = xrotate(angle, A)
        M = [ 1 0 0 0; 0 cos(angle) sin(angle) 0; 0 -sin(angle) cos(angle) 0; 0 0 0 1];
        A = A*M;
    end

    %Rotate object about z-axis
    function A = zrotate(angle, A)
        M = [ cos(angle) sin(angle) 0 0; -sin(angle) cos(angle) 0 0; 0 0 1 0; 0 0 0 1];
        A = A*M;
    end

    %Translate object
    function A = translation(tx, ty, tz, A)
        M = [1 0 0 0; 0 1 0 0; 0 0 1 0; tx ty tz 1];
        A = A*M;
    end

    %Scale object
    function A = scaling(sx, sy, sz, A)
        M = [ sx 0 0 0; 0 sy 0 0; 0 0 sz 0; 0 0 0 1];
        A = A*M;
    end

    a = rectpos;
    b = trappos;
    
    %This code creates the first rectangular wall of house
    a = xrotate(pi/2, a);
    a = zrotate(pi/2,a);
    rect(a, 'y')
    
    %This code creates one of the trapezoid side walls
    b = xrotate(pi/2,b);
    b = translation(0, 1, 0, b);
    trap(b, 'y')
    
    a = rectpos;
    b = trappos;
    
    %This code creates the other rectangular-side wall
    a = yrotate(-pi/2, a);
    a = translation(1, 0, 0, a);
    rect(a, 'y')
    
    %This code creates the other trapezoidal-side wall
    b = xrotate(pi/2, b);
    b = translation( 0, 2, 0, b);
    trap(b, 'y')
    
    a = rectpos;
    b = rectpos;
    
    % This code does one part of roof
    a = yrotate(pi/5, a);
    a = scaling(.73, 1.2, 1, a);
    a = translation( 0, 0, .7, a);
    a = translation( .07, 0, 0, a);
    a = translation( 0, -.1, 0, a);
    rect(a, 'g')
    
    %This code does the other part of roof
    b = yrotate(-pi/5, b);
    b = scaling(.73, 1.2, 1, b);
    b = translation(0, 0, .11, b);
    b = translation(.34, 0, 0, b);
    b = translation( 0, -.1, 0, b);
    rect(b, 'g')
    
    %This code creates the red door
    a = rectpos;
    a = yrotate(-pi/2, a);
    a = scaling(.5, .25, .9, a);
    a = translation(.499, 0, 0, a);
    a = translation(0, .38, 0, a);
    rect(a,'r')
    
    %This creates the blue fencing
    x_movement = -.25;
    for i = 1: 20
        b = trappos;
        b = xrotate(pi/2, b);
        b = scaling(.0625, 1, .5, b);
        b = translation(x_movement, .5, 0, b);
        trap(b, 'b');
        x_movement = x_movement + .0625;
    end
    
    
    
    view([2,.5,1])
    
    


end