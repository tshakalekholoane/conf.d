#ifndef __APPLE__
#error "This program is intended to only run on macOS."
#endif

#include <errno.h>
#include <getopt.h>
#include <objc/message.h>
#include <pwd.h>
#include <stdio.h>
#include <string.h>
#include <unistd.h>

#ifndef CAN_BUILD
#define CAN_BUILD "HEAD"
#endif

static const char* usage = "usage: can [-h | -V] [--] file ...";

// Objective-C messaging primitives require that functions be cast to an
// appropriate function pointer type before being called.

static struct objc_object* file_manager_default_manager(void) {
  struct objc_class* file_manager = objc_getClass("NSFileManager");
  typedef struct objc_object* (*send_type)(struct objc_class*, struct objc_selector*);
  send_type func = (send_type)objc_msgSend;
  return func(file_manager, sel_registerName("defaultManager"));
}

static struct objc_object* file_manager_string_with_file_system_representation(struct objc_object* self, const char string[static 1]) {
  typedef struct objc_object* (*send_type)(struct objc_object*, struct objc_selector*, const char*, unsigned long);
  send_type func = (send_type)objc_msgSend;
  return func(self, sel_registerName("stringWithFileSystemRepresentation:length:"), string, strlen(string));
}

static bool file_manager_trash_item_at_url(struct objc_object* self, struct objc_object* url, struct objc_object** error) {
  typedef bool (*send_type)(struct objc_object*, struct objc_selector*, struct objc_object*, struct objc_object*, struct objc_object**);
  send_type func = (send_type)objc_msgSend;
  return func(self, sel_registerName("trashItemAtURL:resultingItemURL:error:"), url, NULL, error);
}

static struct objc_object* error_localized_description(struct objc_object* self) {
  typedef struct objc_object* (*send_type)(struct objc_object*, struct objc_selector*);
  send_type func = (send_type)objc_msgSend;
  return func(self, sel_registerName("localizedDescription"));
}

static const char* string_utf8_string(struct objc_object* self) {
  typedef const char* (*send_type)(struct objc_object*, struct objc_selector*);
  send_type func = (send_type)objc_msgSend;
  return func(self, sel_registerName("UTF8String"));
}

static struct objc_object* url_file_url_with_path(struct objc_object* string) {
  struct objc_class* url = objc_getClass("NSURL");
  typedef struct objc_object* (*send_type)(struct objc_class*, struct objc_selector*, struct objc_object*);
  send_type func = (send_type)objc_msgSend;
  return func(url, sel_registerName("fileURLWithPath:"), string);
}

int main(int argc, char* argv[argc + 1]) {
  int opt;
  while ((opt = getopt(argc, argv, "hV")) != -1) {
    switch (opt) {
    case 'h':
      printf("%s\n", usage);
      return EXIT_SUCCESS;
    case 'V':
      printf("can %s\n", CAN_BUILD);
      return EXIT_SUCCESS;
    default:
      fprintf(stderr, "%s\n", usage);
      return EXIT_FAILURE;
    }
  }
  if (__builtin_expect(argc == 1, false)) {
    fprintf(stderr, "%s\n", usage);
    return EXIT_FAILURE;
  }
  argc--;
  argv++;

  for (ssize_t i = 0; i < (ssize_t)argc; i++) {
    const char* name = argv[i];
    if (__builtin_expect(strcmp(name, ".") == 0 || strcmp(name, "..") == 0 || strcmp(name, "/") == 0, false)) {
      fprintf(stderr, "\"/\", \".\", and \"..\" may not be removed.\n");
      return EXIT_FAILURE;
    }
  }

  // Avoid using the root user's trash when invoked with sudo.
  const char* superuser = getenv("SUDO_USER");
  if (__builtin_expect(superuser != NULL, false)) {
    struct passwd* entry = getpwnam(superuser);
    if (__builtin_expect(!entry || seteuid(entry->pw_uid), false)) {
      fprintf(stderr, "%s\n", strerror(errno));
      return EXIT_FAILURE;
    }
  }

  // Ignore flag separator.
  if (__builtin_expect(strcmp(argv[0], "--") == 0, false)) {
    argc--;
    argv++;
  }

  int exit_code = EXIT_SUCCESS;
  struct objc_object* file_manager = file_manager_default_manager();
  for (ssize_t i = 0; i < (ssize_t)argc; i++) {
    const char* name = argv[i];
    struct objc_object* path = file_manager_string_with_file_system_representation(file_manager, name);
    struct objc_object* url = url_file_url_with_path(path);
    struct objc_object* error;
    if (__builtin_expect(!file_manager_trash_item_at_url(file_manager, url, &error), false)) {
      struct objc_object* description = error_localized_description(error);
      fprintf(stderr, "%s\n", string_utf8_string(description));
      exit_code = EXIT_FAILURE;
    }
  }
  return exit_code;
}
