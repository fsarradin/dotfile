
Config {
    font = "-misc-fixed-*-*-*-*-13-*-*-*-*-*-*-*",
    bgColor = "#000000",
    fgColor = "#ffffff",
    position = TopW L 100,
    commands = [
        Run StdinReader,
        Run Cpu ["-L", "3", "-H", "50", "--normal", "green", "--high", "red"] 10,
        Run Memory ["-t", "Mem: <usedratio>%"] 10,
        Run Swap [] 10,
        Run Network "eth0" ["-L", "0", "-H", "32", "--normal", "green", "--high", "red"] 10
    ],
    sepChar = "%",
    alignSep = "}{",
    template = " [ %StdinReader% ] }{ [ %cpu% | %memory% * %swap% | %eth0% | <fc=#FFFFCC>%date%</fc> ] "
}

