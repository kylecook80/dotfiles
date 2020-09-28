#ifndef _UTIL_H_
#define _UTIL_H_

#define SMOLBUF 64
#define BUFSIZE 256
#define MAXBUF 1024

#define STRMAX 100

#ifndef DEBUG
#define DEBUG false
#endif

#define dprint(msg) \
do { if(DEBUG) fprintf(stderr, "%s:%d:%s(): " msg, __FILE__, \
	__LINE__, __func__); } while (0)

#define dprintf(fmt, ...) \
do { if (DEBUG) fprintf(stderr, "%s:%d:%s(): " fmt, __FILE__, \
	__LINE__, __func__, __VA_ARGS__); } while (0)

#define warning(msg) fprintf(stderr, "Warning: %s\n", msg)
#define fwarning(fmt, ...) fprintf(stderr, "Warning: " fmt "\n", __VA_ARGS__)

#define error(msg) \
do { fprintf(stderr, "Error: %s\n", msg); exit(EXIT_FAILURE); } while (0)

#define ferror(fmt, ...) \
do { fprintf(stderr, "Error: " fmt "\n", __VA_ARGS__); exit(EXIT_FAILURE); } while (0)

#ifdef LINUX
size_t strlcpy(char *dst, const char *src, size_t dsize);
size_t strlcat(char *dst, const char *src, size_t dsize);
#endif

#endif // _UTIL_H_
