/* Taken from https://github.com/djpohly/dwl/issues/466 */
#define COLOR(hex)    { ((hex >> 24) & 0xFF) / 255.0f, \
                        ((hex >> 16) & 0xFF) / 255.0f, \
                        ((hex >> 8) & 0xFF) / 255.0f, \
                        (hex & 0xFF) / 255.0f }

static const float rootcolor[]             = COLOR(0x120707ff);
static uint32_t colors[][3]                = {
	/*               fg          bg          border    */
	[SchemeNorm] = { 0xc3c1c1ff, 0x120707ff, 0x6a5656ff },
	[SchemeSel]  = { 0xc3c1c1ff, 0xD0745Dff, 0xA35A5Bff },
	[SchemeUrg]  = { 0xc3c1c1ff, 0xA35A5Bff, 0xD0745Dff },
};
