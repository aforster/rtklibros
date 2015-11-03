# ROS message for RTKLib observation data entry (obsd_t in rtklib.h)

time time      # receiver sampling time (GPST)
uint8 sat      # satellite number
uint8 rcv      # receiver number
uint8[3] SNR   # Signal strength (0.25dBHz) (NFREQ+NEXOBS=3)
uint8[3] LLI   # loss of lock indicator
uint8[3] code  # code indicator (CODE_???)
float64[3] L   # carrier-phase [cycle]
float64[3] P   # pseudorange [m]
float64[3] D   # doppler frequency [Hz]
