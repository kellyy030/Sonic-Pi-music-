use_bpm 140

# import
intro_played = false
live_loop :intro do
  if !intro_played
    use_synth :piano
    play_pattern_timed [:C4, :D4, :E4], [0.5, 0.5, 0.5]
    sleep 1
    play_pattern_timed [:G4, :F4, :E4], [0.5, 0.5, 0.5]
    sleep 1
    intro_played = true
  end
  sleep 1
end

# drum
live_loop :drums do
  sleep 10 if !intro_played  # wait for import
  sample :bd_ada
  sleep 0.5
  sample :drum_cymbal_closed
  sleep 0.25
  sample :drum_snare_soft
  sleep 0.25
end

# main
melodies = [
  [:C5, :D5, :E5, :D5],
  [:E5, :F5, :G5, :A5],
  [:G5, :F5, :E5, :D5],
  [:D5, :C5, :B4, :A4]
]

live_loop :main_melody, sync: :intro do
  use_synth :piano
  melodies.each do |melody|
    play_pattern_timed melody, [0.5, 0.5, 0.5, 0.5]
    sleep 1
  end
  stop
end
# drum
live_loop :drums do
  sleep 6 if !intro_played  # wait for import finish
  sample :bd_ada
  sleep 0.5
  sample :drum_cymbal_closed
  sleep 0.25
  sample :drum_snare_soft
  sleep 0.25
  stop if beat > 80
end

# chords accompaniment
live_loop :chords, sync: :main_melody do
  use_synth :piano
  
  play_chord [:C4, :E4, :G4], release: 2
  sleep 2
  
  play_chord [:A3, :C4, :E4], release: 2
  sleep 2
  
  play_chord [:F3, :A3, :C4], release: 2
  sleep 1
  
  play_chord [:G3, :B3, :D4], release: 1
  sleep 1
  stop if beat > 96
end

# second
live_loop :secondary_melody, sync: :main_melody do
  use_synth :pluck
  sleep 4  # delay
  
  play_pattern_timed [:A4, :G4, :F4, :E4, :D4, :E4, :F4], [0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 1]
  stop if beat > 96
end

# low
live_loop :bass_line, sync: :main_melody do
  use_synth :fm
  sleep 5  # delay main and second melody dislocation
  
  play_pattern_timed [:C2, :C3, :E3, :A2, :A2, :A3, :F2, :G2], [1, 0.5, 0.5, 1, 0.5, 0.5, 1, 1]
  stop if beat > 96
end
use_bpm 140

# continue melody
extended_melodies = [
  [:B4, :C5, :D5, :C5, :B4],
  [:A4, :B4, :C5, :B4, :A4],
  [:G4, :A4, :B4, :A4, :G4]
]

live_loop :extended_melody do
  use_synth :piano
  extended_melodies.each do |melody|
    play_pattern_timed melody, [0.25, 0.25, 0.25, 0.25, 1]
    sleep 0.5
  end
  stop
end

# continue drums
live_loop :extended_drums do
  sleep 8 if !intro_played  # make sure import part finish star
  sample :bd_ada
  sleep 0.5
  sample :drum_cymbal_closed
  sleep 0.25
  sample :drum_snare_soft
  sleep 0.25
  stop if beat > 32 # stop drum melody，15s
end
use_bpm 140

# new
new_melodies = [
  [:A4, :G4, :F4, :G4, :A4],
  [:B4, :A4, :G4, :A4, :B4],
  [:C5, :B4, :A4, :B4, :C5]
]

live_loop :new_melody do
  use_synth :piano
  new_melodies.each do |melody|
    play_pattern_timed melody, [0.25, 0.25, 0.25, 0.25, 1]
    sleep 0.5
  end
  stop
end

# new drums
live_loop :new_drums do
  sleep 10 if !intro_played  # 确保在引入部分之
  sample :bd_ada
  sleep 0.5
  sample :drum_cymbal_closed
  sleep 0.25
  sample :drum_snare_soft
  sleep 0.25
  stop if beat > 48 # stop drums cycle，15s
end
use_bpm 140

# more
further_melodies = [
  [:D5, :E5, :F5, :E5, :D5],
  [:C5, :D5, :E5, :D5, :C5],
  [:B4, :C5, :D5, :C5, :B4]
]

live_loop :further_melody do
  use_synth :piano
  further_melodies.each do |melody|
    play_pattern_timed melody, [0.25, 0.25, 0.25, 0.25, 1]
    sleep 0.5
  end
  stop
end

# delay drums
live_loop :further_drums do
  sleep 6 if !intro_played  #
  sample :bd_ada
  sleep 0.5
  sample :drum_cymbal_closed
  sleep 0.25
  sample :drum_snare_soft
  sleep 0.25
  stop if beat > 64 # stop drums cycle，15s
end
use_bpm 140

# new
next_melodies = [
  [:E5, :F5, :G5, :F5, :E5],
  [:D5, :E5, :F5, :E5, :D5],
  [:C5, :D5, :E5, :D5, :C5]
]

live_loop :next_melody do
  use_synth :piano
  next_melodies.each do |melody|
    play_pattern_timed melody, [0.25, 0.25, 0.25, 0.25, 1]
    sleep 0.5
  end
  stop
end

# continue
live_loop :next_drums do
  sleep 8 if !intro_played  #
  sample :bd_ada
  sleep 0.5
  sample :drum_cymbal_closed
  sleep 0.25
  sample :drum_snare_soft
  sleep 0.25
  stop if beat > 80 # stop drums
end

use_bpm 140

define :fade_out_amp do |start_time, current_time, duration|
  if current_time <= start_time
    return 1
  elsif current_time >= start_time + duration
    return 0
  else
    progress = (current_time - start_time) / duration
    return 1 - progress
  end
end

# end
live_loop :ending_part do
  start_time = 50
  fade_duration = 15
  current_time = vt  #
  
  # end 50s-60s
  if current_time < start_time
    sleep start_time - current_time
  elsif current_time > start_time + fade_duration
    stop
  end
  
  amp_value = fade_out_amp(start_time, current_time, fade_duration)
  
  use_synth :piano
  
  # main
  play_pattern_timed [:G4, :F4, :E4], [0.5, 0.5, 1], amp: amp_value
  play_pattern_timed [:C4, :D4, :E4], [0.5, 0.5, 1], amp: amp_value
  
  #
  play_chord [:C4, :E4, :G4], release: 2, amp: amp_value
  sleep 2
  
  play_chord [:A3, :C4, :E4], release: 2, amp: amp_value
  sleep 2
  
  play_chord [:F3, :A3, :C4], release: 2, amp: amp_value
  sleep 2
  
  play_chord [:G3, :B3, :D4], release: 1, amp: amp_value
  sleep 1
end