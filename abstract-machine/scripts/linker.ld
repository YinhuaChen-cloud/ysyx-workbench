/* Five ways to indicate the entry point of executable file(priority high to low) */
/* 1. the `-e' entry command-line option; */
/* 2. the ENTRY(symbol) command in a linker control script; */
/* 3. the value of the symbol start, if present; */
/* 4. the address of the first byte of the .text section, if present; */
/* 5. The address 0. */
ENTRY(_start)

/* You may use at most one SECTIONS command in a script file, but you can have as many statements within it as you wish. Statements within the SECTIONS command can do one of three things: */

/* 1. define the entry point; */
/* 2. assign a value to a symbol; */
/* 3. describe the placement of a named output section, and which input sections go into it. */

SECTIONS {
  /* _pmem_start and _entry_offset are defined in LDFLAGS */

/* The special linker variable dot `.' always contains the current output location counter. Since the . always refers to a location in an output section, it must always appear in an expression within a SECTIONS command. The . symbol may appear anywhere that an ordinary symbol is allowed in an expression, but its assignments have a side effect. Assigning a value to the . symbol will cause the location counter to be moved. This may be used to create holes in the output section. The location counter may never be moved backwards.  */

  . = _pmem_start + _entry_offset; /* location_counter = 0x80000000 + 0x0 */

	/* The simplest format of section definition is as follows: */
/* SECTIONS { ... 
   secname : { 
     contents 
   } 
   ... } */

/* The whitespace around secname is required */

/* secname must meet the constraints of your output format. In formats which only support a limited number of sections, such as a.out, the name must be one of the names supported by the format (a.out, for example, allows only .text, .data or .bss). If the output format supports any number of sections, but with numbers and not names (as is the case for Oasys), the name should be supplied as a quoted numeric string. */

/* The contents in a section definition can be one of the followings: */
	/* 1. .data : { afile.o bfile.o cfile.o } all sections in the file will be placed into .data ouput section. If the file name has already been mentioned in another section definition, with an explicit section name list "filename( section , section, ... )", then only those sections which have not yet been allocated are used. */
	/* 2. * (section, section, ...). Instead of explicitly naming particular input files in a link control script, you can refer to all files from the ld command line: use `*' instead of a particular file name before the parenthesized input-file section list. If you have already explicitly included some files by name, `*' refers to all remaining files--those whose places in the output file have not yet been defined.  */

  .text : {
    *(entry)
    *(.text*)
  }
  etext = .;
  _etext = .;
  .rodata : {
    *(.rodata*)
  }
  .data : {
    *(.data)
  }
  edata = .;
  _data = .;
  .bss : {
	_bss_start = .;
    *(.bss*)
    *(.sbss*)
    *(.scommon)
  }

/* ALIGN(exp): */
/* Return the result of the current location counter (.) aligned to the next exp boundary. exp must be an expression whose value is a power of two. This is equivalent to (. + exp - 1) & ~(exp - 1) */
/* ALIGN doesn't change the value of the location counter--it just does arithmetic on it.  */
  _stack_top = ALIGN(0x1000);
  . = _stack_top + 0x8000;
  _stack_pointer = .;
  end = .;
  _end = .;
  _heap_start = ALIGN(0x1000);
}
