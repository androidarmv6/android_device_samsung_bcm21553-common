// Property and control overrides for BCM21553 series devices

#define PROPERTY_PERMS_APPEND \
    { "service.brcm.bt.",      AID_RADIO,    0 }, \
    { "gps.fd.",               AID_GPS,      0 }, \
    { "gps.fd.",               AID_RADIO,    0 }, \
    { "gps.fd.",               AID_SYSTEM,   0 },

