import pygame
import socket
import sys

# Mapping for Nintendo Switch Pro Controller
SWITCH_BUTTONS = {
    0: 'A',
    1: 'B',
    4: 'SELECT',
    6: 'START',
    11:'UP',
    12:'DOWN',
    13:'LEFT',
    14:'RIGHT',
    9: 'L',
    10:'R'
}

GBA_BITS = {
    'A':      0,
    'B':      1,
    'SELECT': 2,
    'START':  3,
    'RIGHT':  4,
    'LEFT':   5,
    'UP':     6,
    'DOWN':   7,
    'R':      8,
    'L':      9
}

pygame.init()
pygame.joystick.init()

joystick_count = pygame.joystick.get_count()

if joystick_count < 1:
    print("Connect a controller.")
    sys.exit()

joysticks = []

# Initialize all to "pump" the events
for i in range(joystick_count):
    js = pygame.joystick.Joystick(i)
    js.init()
    joysticks.append(js)
    print(f"ID {i}: {js.get_name()}")

print("Press any button on the controller you want to use for this script...")

chosen_controller_id = None
chosen_joystick = None

while chosen_controller_id is None:
    for event in pygame.event.get():
        if event.type == pygame.JOYBUTTONDOWN:
            chosen_controller_id = event.instance_id
            print(f"Connected.")


def send_gba_mask(mask):
    try:
        s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        s.settimeout(0.05)
        s.connect(("127.0.0.1", 61337))
        s.sendall(f"SET_MASK {mask}\n".encode())
        s.shutdown(socket.SHUT_WR)
        s.close()
    except Exception as e:
        print(f"Failed to send data: {e}")
        pass


print("Control-C to disconnect.")
running = True
current_pressed = set()
default_mask = 0x03FF

try:
    while running:
        for event in pygame.event.get():
            if hasattr(event, "instance_id") and event.instance_id == chosen_controller_id:
                if event.type in (pygame.JOYBUTTONDOWN, pygame.JOYBUTTONUP):
                    btn_name = SWITCH_BUTTONS.get(event.button)
                    if btn_name:
                        if event.type == pygame.JOYBUTTONDOWN:
                            current_pressed.add(btn_name)
                        else:
                            current_pressed.discard(btn_name)
               
                    # GBA uses Active Low: 0x03FF is all buttons released
                    mask = default_mask
                    for btn in current_pressed:
                        mask &= ~(1 << GBA_BITS[btn])
               
                    print(f"{mask}")
                    send_gba_mask(mask)
except KeyboardInterrupt:
    send_gba_mask(default_mask) # Reset buttons on exit
    print("\nDisconnected.")
finally:
    pygame.quit()
