import re

file_path = 'output.txt'

exiting_lines = []
configurations = []

# Regular expression to extract tick value
tick_regex = re.compile(r"Exiting @ tick (\d+)")

with open(file_path, 'r') as file:
    lines = file.readlines()
    config = ""
    for line in lines:
        if line.startswith("Results for --cpu-type"):
            config = line.strip()
        tick_match = tick_regex.search(line)
        if tick_match:
            tick = int(tick_match.group(1))  # Extract the tick value
            exiting_lines.append((tick, config))

# Find the configuration with the shortest tick
shortest_tick_config = min(exiting_lines, key=lambda x: x[0])
print(shortest_tick_config)
