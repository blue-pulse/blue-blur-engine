/// @description Timestamp
image_index = objScreen.image_index div 8;
var time = objStage.stage_time;

// Minutes
var minutes = string(time div 3600);

// Seconds
var seconds = string((time div 60) mod 60);
if (seconds < 10) seconds = "0" + seconds;

// Centiseconds
var centiseconds = string(floor(time / 0.6) mod 100);
if (centiseconds < 10) centiseconds = "0" + centiseconds;

// Update timestamp
timestamp = minutes + ":" + seconds + ":" + centiseconds;