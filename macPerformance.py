import time
import csv
import sys
import os
import psutil

output_file = "SystemPerformance_Mac.csv"
interval = 0.5  # Interval in seconds between each measurement

# Initialize CSV file with headers
with open(output_file, 'w', newline='') as csvfile:
    csv_writer = csv.writer(csvfile)
    csv_writer.writerow(['Timestamp', 'CPU Usage (%)', 'Available Memory (MB)'])

try:
    while True:
        timestamp = time.strftime('%Y-%m-%d %H:%M:%S')
        cpu_usage = psutil.cpu_percent(interval=interval)
        mem_info = psutil.virtual_memory()
        available_memory = mem_info.available / (1024 ** 2)

        # Save data to CSV file
        with open(output_file, 'a', newline='') as csvfile:
            csv_writer = csv.writer(csvfile)
            csv_writer.writerow([timestamp, cpu_usage, available_memory])

except KeyboardInterrupt:
    print("Monitoring stopped.")