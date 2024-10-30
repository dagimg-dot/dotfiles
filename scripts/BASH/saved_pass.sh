# Function to select a WiFi and display the password

pas() {
  selected_wifi=$(nmcli connection show | grep wifi | fzf --prompt="Select WiFi: ")

  # Check if a WiFi is selected
  if [ -z "$selected_wifi" ]; then
    echo "No WiFi selected."
    return 1
  fi

  rev_line=$(echo "$selected_wifi" | awk '{ for (i=NF; i>0; i--) printf "%s ", $i; print "" }')

  rev_wifi_name=$(echo "$rev_line" | awk -F' ' '{for (i=4; i<=NF; i++) printf "%s ", $i; print ""}')

  wifi_name=$(echo "$rev_wifi_name" | awk '{ for (i=NF; i>0; i--) printf "%s ", $i; print "" }')

  # Trim leading and trailing spaces
  wifi_name="${wifi_name#"${wifi_name%%[![:space:]]*}"}"
  wifi_name="${wifi_name%"${wifi_name##*[![:space:]]}"}"

  # Display password for the selected WiFi
  # sudo nmcli connection show "$wifi_name" -s | grep psk
  sudo nmcli connection show "$wifi_name" -s | grep psk
}
