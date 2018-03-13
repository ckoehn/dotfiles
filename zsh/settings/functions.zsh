tunnel-anything () {
    ssh -M -S /tmp/tunnel-anything -fnNT -L "9999:localhost:$1" "$2"
    vared -p "Tunnel to '$2', Port 9999->$1 (Press Enter to quit)" -c tmp
    ssh -S /tmp/tunnel-anything -O exit "$2"
}
