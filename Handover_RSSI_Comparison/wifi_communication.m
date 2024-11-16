function rssi_log = wifi_communication(robot_positions_over_time, ap_positions, time_steps)
    % Optimized WiFi Communication using WLAN Toolbox for initial RSSI calculation

    % WLAN Channel Model setup (used only for reference RSSI calculation)
    chan = wlanTGnChannel;
    chan.DelayProfile = 'Model-D';  % Indoor office environment model
    chan.SampleRate = 20e6;  % Sample rate in Hz

    % Generate WLAN waveform (simple BPSK example)
    cfg = wlanNonHTConfig;  % Configuration object for a non-HT transmission
    cfg.MCS = 0;  % Use a low MCS for testing
    txWaveform = wlanWaveformGenerator([1; 0; 1; 0], cfg);

    % Calculate reference RSSI using the channel model
    reference_rssi_values = zeros(size(ap_positions, 1), 1);
    for ap = 1:size(ap_positions, 1)
        % Pass the waveform through the channel to get the reference RSSI
        rxWaveform = chan(txWaveform);
        reference_rssi_values(ap) = 10 * log10(mean(abs(rxWaveform).^2));
    end

    % Parameters for simplified distance-based path loss model
    path_loss_exponent = 2.0;  % Typical value for indoor environments
    reference_distance = 1;  % Reference distance in meters

    num_robots = size(robot_positions_over_time, 2);
    num_aps = size(ap_positions, 1);
    rssi_log = zeros(num_robots, num_aps, time_steps);  % Store RSSI values over time

    % Iterate over each time step
    for t = 1:time_steps
        for r = 1:num_robots
            robot_pos = squeeze(robot_positions_over_time(t, r, :))';
            for ap = 1:num_aps
                % Calculate distance from robot to AP
                distance = norm(robot_pos - ap_positions(ap, :));
                
                % Ensure the distance is not zero to prevent log errors
                if distance < reference_distance
                    distance = reference_distance;
                end
                
                % Apply the path loss model: RSSI = reference_rssi - 10 * path_loss_exponent * log10(distance / reference_distance)
                rssi_log(r, ap, t) = reference_rssi_values(ap) - 10 * path_loss_exponent * log10(distance / reference_distance);
            end
        end
    end
end
