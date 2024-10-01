function rssi_log = wlan_communication(robot_positions_over_time, ap_positions, time_steps)
    % Refined WiFi Communication using WLAN Toolbox
    
    % WLAN Channel Model for indoor environment
    chan = wlanTGnChannel;
    chan.DelayProfile = 'Model-D'; % Indoor office environment model
    chan.SampleRate = 20e6; % Sample rate in Hz
    
    num_robots = size(robot_positions_over_time, 2);
    num_aps = size(ap_positions, 1);
    rssi_log = zeros(num_robots, num_aps, time_steps);  % Store RSSI values over time
    
    % Generate WLAN waveform (simple BPSK example)
    cfg = wlanNonHTConfig; % Configuration object for a non-HT transmission
    cfg.MCS = 0; % Use a low MCS for testing
    
    txWaveform = wlanWaveformGenerator([1;0;1;0], cfg);
    
    % Iterate over each time step
    for t = 1:time_steps
        for r = 1:num_robots
            robot_pos = squeeze(robot_positions_over_time(t, r, :))';
            for ap = 1:num_aps
                % Calculate distance and simulate transmission
                distance = norm(robot_pos - ap_positions(ap, :));
                
                % Pass the waveform through the channel
                rxWaveform = chan(txWaveform);
                
                % Calculate RSSI using received waveform
                rssi_log(r, ap, t) = 10*log10(mean(abs(rxWaveform).^2)) - 10*log10(distance);
            end
        end
    end
end
