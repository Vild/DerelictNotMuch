/* notmuch - Not much of an email library, (just index and search)
 *
 * Copyright © 2009 Carl Worth
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see https://www.gnu.org/licenses/ .
 *
 * Author: Carl Worth <cworth@cworth.org>
 */

module derelict.notmuch.types;

extern (C) @nogc nothrow:

enum LIBNOTMUCH_MAJOR_VERSION = 4;
enum LIBNOTMUCH_MINOR_VERSION = 4;
enum LIBNOTMUCH_MICRO_VERSION = 0;

/**
 * Notmuch boolean type.
 */
alias notmuch_bool_t = bool;

///
alias notmuch_status_t = int;

/**
 * Status codes used for the return values of most functions.
 *
 * A zero value (NOTMUCH_STATUS_SUCCESS) indicates that the function
 * completed without error. Any other value indicates an error.
 */
enum : notmuch_status_t {
	/**
		* No error occurred.
		*/
	NOTMUCH_STATUS_SUCCESS = 0,
	/**
		* Out of memory.
		*/
	NOTMUCH_STATUS_OUT_OF_MEMORY,
	/**
		* An attempt was made to write to a database opened in read-only
		* mode.
		*/
	NOTMUCH_STATUS_READ_ONLY_DATABASE,
	/**
		* A Xapian exception occurred.
		*
		* @todo We don't really want to expose this lame XAPIAN_EXCEPTION
		* value. Instead we should map to things like DATABASE_LOCKED or
		* whatever.
		*/
	NOTMUCH_STATUS_XAPIAN_EXCEPTION,
	/**
		* An error occurred trying to read or write to a file (this could
		* be file not found, permission denied, etc.)
		*/
	NOTMUCH_STATUS_FILE_ERROR,
	/**
		* A file was presented that doesn't appear to be an email
		* message.
		*/
	NOTMUCH_STATUS_FILE_NOT_EMAIL,
	/**
		* A file contains a message ID that is identical to a message
		* already in the database.
		*/
	NOTMUCH_STATUS_DUPLICATE_MESSAGE_ID,
	/**
		* The user erroneously passed a NULL pointer to a notmuch
		* function.
		*/
	NOTMUCH_STATUS_NULL_POINTER,
	/**
		* A tag value is too long (exceeds NOTMUCH_TAG_MAX).
		*/
	NOTMUCH_STATUS_TAG_TOO_LONG,
	/**
		* The notmuch_message_thaw function has been called more times
		* than notmuch_message_freeze.
		*/
	NOTMUCH_STATUS_UNBALANCED_FREEZE_THAW,
	/**
		* notmuch_database_end_atomic has been called more times than
		* notmuch_database_begin_atomic.
		*/
	NOTMUCH_STATUS_UNBALANCED_ATOMIC,
	/**
		* The operation is not supported.
		*/
	NOTMUCH_STATUS_UNSUPPORTED_OPERATION,
	/**
		* The operation requires a database upgrade.
		*/
	NOTMUCH_STATUS_UPGRADE_REQUIRED,
	/**
		* There is a problem with the proposed path, e.g. a relative path
		* passed to a function expecting an absolute path.
		*/
	NOTMUCH_STATUS_PATH_ERROR,
	/**
		* One of the arguments violates the preconditions for the
		* function, in a way not covered by a more specific argument.
		*/
	NOTMUCH_STATUS_ILLEGAL_ARGUMENT,
	/**
		* Not an actual status value. Just a way to find out how many
		* valid status values there are.
		*/
	NOTMUCH_STATUS_LAST_STATUS
}

/* Various opaque data types. For each notmuch_<foo>_t see the various
 * notmuch_<foo> functions below. */
struct notmuch_database_t {
	@disable this();
	@disable this(this);
}

struct notmuch_query_t {
	@disable this();
	@disable this(this);
}

struct notmuch_threads_t {
	@disable this();
	@disable this(this);
}

struct notmuch_thread_t {
	@disable this();
	@disable this(this);
}

struct notmuch_messages_t {
	@disable this();
	@disable this(this);
}

struct notmuch_message_t {
	@disable this();
	@disable this(this);
}

struct notmuch_tags_t {
	@disable this();
	@disable this(this);
}

struct notmuch_directory_t {
	@disable this();
	@disable this(this);
}

struct notmuch_filenames_t {
	@disable this();
	@disable this(this);
}

struct notmuch_config_list_t {
	@disable this();
	@disable this(this);
}

///
alias notmuch_database_mode_t = int;

/**
 * Database open mode for notmuch_database_open.
 */
enum : notmuch_database_mode_t {
	/**
		* Open database for reading only.
		*/
	NOTMUCH_DATABASE_MODE_READ_ONLY = 0,
	/**
		* Open database for reading and writing.
		*/
	NOTMUCH_DATABASE_MODE_READ_WRITE
}

/**
 * A callback invoked by notmuch_database_compact to notify the user
 * of the progress of the compaction process.
 */
alias notmuch_compact_status_cb_t = void function(const char* message, void* closure);

///
alias notmuch_sort_t = int;

/**
 * Sort values for notmuch_query_set_sort.
 */
enum : notmuch_sort_t {
	/**
		* Oldest first.
		*/
	NOTMUCH_SORT_OLDEST_FIRST,
	/**
		* Newest first.
		*/
	NOTMUCH_SORT_NEWEST_FIRST,
	/**
		* Sort by message-id.
		*/
	NOTMUCH_SORT_MESSAGE_ID,
	/**
		* Do not sort.
		*/
	NOTMUCH_SORT_UNSORTED
}

///
alias notmuch_exclude_t = int;

/**
 * Exclude values for notmuch_query_set_omit_excluded. The strange
 * order is to maintain backward compatibility: the old FALSE/TRUE
 * options correspond to the new
 * NOTMUCH_EXCLUDE_FLAG/NOTMUCH_EXCLUDE_TRUE options.
 */
enum : notmuch_exclude_t {
	NOTMUCH_EXCLUDE_FLAG,
	NOTMUCH_EXCLUDE_TRUE,
	NOTMUCH_EXCLUDE_FALSE,
	NOTMUCH_EXCLUDE_ALL
}

///
alias notmuch_message_flag_t = int;

/**
 * Message flags.
 */
enum : notmuch_message_flag_t {
	NOTMUCH_MESSAGE_FLAG_MATCH,
	NOTMUCH_MESSAGE_FLAG_EXCLUDED,

	/* This message is a "ghost message", meaning it has no filenames
		* or content, but we know it exists because it was referenced by
		* some other message.  A ghost message has only a message ID and
		* thread ID.
		*/
	NOTMUCH_MESSAGE_FLAG_GHOST,
}
/**
 * The longest possible tag value.
 */
enum NOTMUCH_TAG_MAX = 200;

/**
 * Opaque message property iterator
 */
struct notmuch_message_properties_t {
	@disable this();
	@disable this(this);
}
