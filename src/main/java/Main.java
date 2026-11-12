import java.io.InputStreamReader;
import java.nio.charset.StandardCharsets;

public class Main {
    public static void main(String[] args) throws Exception {
        System.out.println("=== ANALISADOR LEXICO MINILANG ===");
        System.out.println("Digite o código-fonte e finalize com Ctrl+D (Linux/macOS).");
        System.out.println();

        Lexer lexer = new Lexer(
            new InputStreamReader(System.in, StandardCharsets.UTF_8)
        );

        lexer.yylex();

        System.out.println();
        System.out.println("=== FIM DA ANALISE ===");
    }
}
