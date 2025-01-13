#include "../minitalk.h"

void	print_error(void)
{
	write(2, "Error\n", 6);
	exit(1);
}

void	send_signals(int pid, char *message)
{
	int				letter;
	int				i;

	letter = 0;
	while (message[letter])
	{
		i = -1;
		while (++i < 8)
		{
			if (((unsigned char)(message[letter] >> (7 - i)) & 1) == 0)
				kill(pid, SIGUSR1);
			else if (((unsigned char)(message[letter] >> (7 - i)) & 1) == 1)
				kill(pid, SIGUSR2);
			usleep(50);
		}
	letter++;
	}
	i = 0;
	while (i++ < 8)
	{
		kill(pid, SIGUSR1);
		usleep(50);
	}
}

int main(int argc, char **argv)
{
	int pid;
	char *message;
	if(argc == 3)
	{
		pid = ft_atoi(argv[1]);
		if(!pid)
		{
			print_error();
			return (0);
		}
		message = argv[2];
		if(message[0] == 0)
		{
			print_error();
			return (0);
		}
		send_signals(pid, message);
	}
	else
		ft_putendl_fd("client want ID massage:", 1);
	return (0);
}