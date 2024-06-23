# Simulador CFD

Este é um simples simulador de Dinâmica dos Fluidos Computacional (CFD) implementado em Fortran. O objetivo deste projeto é resolver as equações de Navier-Stokes bidimensionais para um fluido incompressível utilizando um esquema de diferenças finitas.

## Descrição

O simulador resolve as equações de Navier-Stokes para um fluido incompressível em um domínio bidimensional utilizando um método explícito de diferenças finitas. As equações são discretizadas em uma grade uniforme e a solução é avançada no tempo utilizando um esquema de time-stepping.

O código inicializa campos de velocidade e pressão e resolve as equações de Navier-Stokes para calcular a evolução temporal desses campos. Condições de contorno são aplicadas para simular o escoamento em um canal.

## Estrutura do Código

O código é dividido nas seguintes partes principais:

1. **Inicialização**: Campos de velocidade (`u`, `v`) e pressão (`p`) são inicializados.
2. **Laço Temporal**: O código executa um laço sobre os passos de tempo (`nt`), atualizando os campos de velocidade e pressão a cada passo.
3. **Cálculo da Velocidade**: Velocidades provisórias são calculadas usando um método explícito de diferenças finitas.
4. **Condições de Contorno**: Condições de contorno são aplicadas para as velocidades.
5. **Cálculo da Pressão**: A pressão é calculada para assegurar a incompressibilidade do fluido.
6. **Saída de Dados**: Os resultados são escritos em um arquivo `velocity.dat`.

## Uso

### Requisitos

- Um compilador Fortran (por exemplo, `gfortran`)

### Compilação e Execução

1. Clone o repositório:
    ```sh
    git clone https://github.com/Vidortech/SimCDF.git
    cd SimCDF
    ```

2. Compile o código:
   
   `Makefile:`  
    ```sh
    make
    ```
    `
   Gfortran:
   `
    ```
   gfortran main.f90 -o main.x
    ```

4. Execute o programa:
    ```sh
    ./main.x
    ```

Após a execução, o arquivo `velocity.dat` será gerado contendo os resultados da simulação.

### Formato da Saída

O arquivo `velocity.dat` contém a velocidade `u` e `v` para cada ponto da grade no formato:
