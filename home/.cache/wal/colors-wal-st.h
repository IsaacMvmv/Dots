const char *colorname[] = {

  /* 8 normal colors */
  [0] = "#120707", /* black   */
  [1] = "#A35A5B", /* red     */
  [2] = "#D0745D", /* green   */
  [3] = "#E4883F", /* yellow  */
  [4] = "#EB9A69", /* blue    */
  [5] = "#FBC876", /* magenta */
  [6] = "#F7B185", /* cyan    */
  [7] = "#c3c1c1", /* white   */

  /* 8 bright colors */
  [8]  = "#6a5656",  /* black   */
  [9]  = "#A35A5B",  /* red     */
  [10] = "#D0745D", /* green   */
  [11] = "#E4883F", /* yellow  */
  [12] = "#EB9A69", /* blue    */
  [13] = "#FBC876", /* magenta */
  [14] = "#F7B185", /* cyan    */
  [15] = "#c3c1c1", /* white   */

  /* special colors */
  [256] = "#120707", /* background */
  [257] = "#c3c1c1", /* foreground */
  [258] = "#c3c1c1",     /* cursor */
};

/* Default colors (colorname index)
 * foreground, background, cursor */
 unsigned int defaultbg = 0;
 unsigned int defaultfg = 257;
 unsigned int defaultcs = 258;
 unsigned int defaultrcs= 258;
