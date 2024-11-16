function [rssi_log, ap_interactions] = wifi_communication(robot_positions_over_time, ap_positions, time_steps)
    % Refined WiFi Communication with channel assignment and controlled handover behavior
    
    % WLAN Channel Model for indoor environment
    chan = wlanTGnChannel;
    chan.DelayProfile = 'Model-D'; % Indoor office environment model
    chan.SampleRate = 20e6; % Sample rate in Hz
    
    % Assign Wi-Fi channels to APs
    ap_channels = [1, 6, 11, 1];  % Channel allocation for APs (avoiding interference)
    
    num_robots = size(robot_positions_over_time, 2);
    num_aps = size(ap_positions, 1);
    rssi_log = zeros(num_robots, num_aps, time_steps);  % Store RSSI values over time
    ap_interactions = zeros(num_robots, time_steps);  % Track which AP each robot interacts with
    
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
                
                % Calculate RSSI without additional noise for stability
                rssi_log(r, ap, t) = 10 * log10(mean(abs(rxWaveform).^2)) - 10 * log10(distance);
            end
            
            % Determine the AP with the strongest signal
            [~, strongest_ap] = max(rssi_log(r, :, t));
            ap_interactions(r, t) = strongest_ap;
        end
    end
end
