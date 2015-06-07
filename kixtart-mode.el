;;; kixtart-mode.el --- major mode for Kixtart scripting files

;; Version: 20150607.1
;; Homepage: https://github.com/ryrun/kixtart-mode
;; Package-Requires: ((emacs "24"))

;;; Code:

(provide 'kixtart-mode)

;syntax table
(defconst kixtart-mode-syntax-table
  (let ((table (make-syntax-table)))
    (modify-syntax-entry ?' "\"" table)
    (modify-syntax-entry ?\" "\"" table)
    (modify-syntax-entry ?\; "\<" table)
    (modify-syntax-entry ?\n ">" table)
    (modify-syntax-entry ?\r ">" table)
    (modify-syntax-entry ?\> "." table)
    (modify-syntax-entry ?\+ "." table)
    (modify-syntax-entry ?\- "." table)
    (modify-syntax-entry ?\* ". 23n" table)
    (modify-syntax-entry ?\/ ". 14b" table)
    (modify-syntax-entry ?\= "." table)
    (modify-syntax-entry ?\< "." table)
    (modify-syntax-entry ?\> "." table)
    table))

(defun kixtart-gen-regexp-list(list &optional appendstr)
  "function to create regex for functions and keywords case insensivitve."
  (concat "\\(?:^\\|\\s-\\)\\("
	  (mapconcat 'identity
		     (mapcar (lambda(keyword)
			       (concat
				appendstr
				(mapconcat 'identity
					   (mapcar (lambda(chars)
						     (concat
						      "["
						      (downcase (make-string 1 chars))
						      (upcase (make-string 1 chars))
						      "]"
						      )
						     )
						   (string-to-list keyword))
					   ""))
			       ) list)
		     "\\|")
	  "\\)\\>"))

(eval-and-compile
  (setq kixtart-var "$[0-9a-zA-Z]+")
  (setq kixtart-type 
	(kixtart-gen-regexp-list (list "Address" "Build" "CPU" "CRLF" "CSD" "Color" "Comment" "CurDir" "DOS" "Date" "Day" "Domain" "Error" "FullName" "HomeDir" "HomeDrive" "HomeShr" "HostName" "IPAddressX" "InWin" "KiX" "LDomain" "LDrive" "LM" "LServer" "LanRoot" "LogonMode" "LongHomeDir" "MDayNo" "MHz" "MSecs" "MaxPWAge" "Month" "MonthNo" "PID" "PWAge" "PrimaryGroup" "Priv" "ProductSuite" "ProductType" "RAS" "RServer" "Result" "SError" "SID" "ScriptDir" "ScriptExe" "ScriptName" "Site" "StartDir" "SysLang" "TIME" "Ticks" "USERID" "USERLANG" "WDayNo" "WKSTA" "WUserID" "YDayNo" "Year") "@"))
  (setq kixtart-keywords
	(kixtart-gen-regexp-list (list "AScan" "Abs" "AddKey" "AddPrinterConnection" "AddProgramGroup" "AddProgramItem" "Asc" "At" "BackupEventLog" "Beep" "Big" "Box" "Break" "CD" "CDbl" "CInt" "CLS" "CStr" "Call" "Chr" "ClearEventLog" "Close" "Color" "CompareFileTimes" "Cookie1" "Copy" "CreateObject" "Debug" "On" "Off" "DecToHex" "Del" "DelKey" "DelPrinterConnection" "DelProgramGroup" "DelProgramItem" "DelTree" "DelValue" "Dim" "Dir" "Display" "Do Until" "EnumGroup" "EnumIpInfo" "EnumKey" "EnumLocalGroup" "EnumValue" "Execute" "Exist" "Exit" "ExpandEnvironmentVars" "Fix" "FlushKb" "For" "Each" "Next" "FormatNumber" "FreeFileHandle" "Function" "EndFunction " "Get" "GetDiskSpace" "GetFileAttr" "GetFileSize" "GetFileTime" "GetFileVersion" "GetObject" "GetS" "Global" "Go" "Gosub" "Goto" "IIF" "If" "Else" "Endif" "InGroup" "InStr" "InStrRev" "Int" "IsDeclared" "Join" "KbHit" "KeyExist" "LCase" "LTrim" "Left" "Len" "LoadHive" "LoadKey" "LogEvent" "Logoff" "MD" "Macro" "MemorySize" "MessageBox" "Move" "Open" "Play" "Quit" "RD" "RTrim" "ReDim" "ReadLine" "ReadProfileString" "ReadType" "ReadValue" "RedirectOutput" "Return" "Right" "Rnd" "Round" "Run" "SRnd" "SaveKey" "Select" "Case" "EndSelect" "SendKeys" "SendMessage" "Set" "SetAscii" "SetConsole" "SetDefaultPrinter" "SetFileAttr" "SetFocus" "SetL" "SetM" "SetOption" "SetSystemState" "SetTime" "SetTitle" "SetWallpaper" "Shell" "ShowProgramGroup" "ShutDown" "SidToName" "Sleep" "Small" "Split" "Substr" "Trim" "UCase" "Ubound" "UnloadHive" "Use" "Val" "VarType" "VarTypeName" "While" "Loop" "WriteLine" "WriteProfileString" "WriteValue"))
	)
  )

(defconst kixtart-font-lock-defaults
  `(
    (,kixtart-var . font-lock-variable-name-face)
    (,kixtart-type . font-lock-type-face)
    (,kixtart-keywords . font-lock-keyword-face)
    ("?" . font-lock-builtin-face)
    )
  )

(define-derived-mode kixtart-mode fundamental-mode "Kixtart Mode"
  :syntax-table kixtart-mode-syntax-table
  (setq mode-name "Kixtart Mode")
  (set (make-local-variable 'font-lock-defaults) '(kixtart-font-lock-defaults))
  (setq comment-multi-line nil)
  (font-lock-fontify-buffer))

(progn
  (add-to-list 'auto-mode-alist '("\\.kix\\'" . kixtart-mode)))

;;; kixtart-mode.el ends here
