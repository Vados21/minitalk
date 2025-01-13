#include "../minitalk.h"

void	get_text(int sig)
{
	static unsigned char	msg = 0;
	static int				size_bit = 0;

	++size_bit;
	msg = msg >> 1;
	if (sig == SIGUSR1)
		msg = msg | 128;
	if (size_bit == 8)
	{
		ft_putchar_fd(msg, 1);
		size_bit = 0;
	}
}

int	main(void)
{
	pid_t				pid;
	struct sigaction	sa;

	sa.sa_flags = SA_SIGINFO;
	sa.sa_handler = &get_text;
	sigaction(SIGUSR1, &sa, NULL);
	sigaction(SIGUSR2, &sa, NULL);
	pid = getpid();
	ft_putstr_fd("Process ID:  ", 1);
	ft_putnbr_fd(pid, 1);
	write(1, "\n", 1);
	while (1)
		pause();
	return (0);
}
