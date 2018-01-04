#!/usr/bin/awk -f

BEGIN            { print_it = 0  }
/status: active/ { print_it = 1  }
/^($|[^\t])/     { if(print_it) print buffer; buffer = $0; print_it = 0  }
/^\t/            { buffer = buffer "\n" $0  }
END              { if(print_it) print buffer  }
