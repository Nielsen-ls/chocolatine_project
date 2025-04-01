#include <criterion/criterion.h>
#include <criterion/redirect.h>

int mini_printf(const char *format, ...);

void redirect_all_std(void)
{
    cr_redirect_stdout();
    cr_redirect_stderr();
}

Test (mini_printf, string_andint, .init = redirect_all_std)
{
    int age = 18;

    mini_printf("hello world %d", age);
    cr_assert_stdout_eq_str("hello world 18");
}

Test (mini_printf, simple_string, .init = redirect_all_std)
{
    char *str = "Hello World";

    mini_printf("%s\n", str);
    cr_assert_stdout_eq_str("Hello World\n");
}

Test (mini_printf, simple_caractere, .init = redirect_all_std)
{
    char caractere = 'k';

    mini_printf("hello world %c", caractere);
    cr_assert_stdout_eq_str("hello world k");
}

Test (mini_printf, pourcent, .init = redirect_all_std)
{
    mini_printf("hello world %%");
    cr_assert_stdout_eq_str("hello world %");
}

Test (mini_printf, all, .init = redirect_all_std)
{
    char caractere = '@';
    char *str = "test passed\n";
    int age = 18;

    mini_printf("hel%dlo %%wor%cld %s", age, caractere, str);
    cr_assert_stdout_eq_str("hel18lo %wor@ld test passed\n");
}