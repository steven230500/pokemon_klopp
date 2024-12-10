# Pokémon Klopp

Pokémon Klopp es una aplicación Flutter que permite explorar, buscar y visualizar información detallada sobre Pokémon utilizando la [PokéAPI](https://pokeapi.co/). La aplicación incluye un diseño limpio, funcionalidad de búsqueda y soporte para scroll infinito.

## Características

- Lista paginada de Pokémon con imágenes y id.
- Función de búsqueda para encontrar Pokémon específicos.
- Animación en la pantalla de inicio.
- Modularidad a través del uso de un micro paquete (**pokemon_api**) para gestionar las llamadas a la API.

---

## Instalación

### Clonar el Proyecto

1. Clona este repositorio en tu máquina local:

   ```bash
   git clone https://github.com/tu_usuario/pokemon_klopp.git
   cd pokemon_klopp
   ```

### Instalar Dependencias

2. Instala las dependencias del proyecto y del micro paquete:

   ```bash
   flutter pub get
   ```

3. Navega al micro paquete (`pokemon_api`) y asegúrate de instalar también sus dependencias:

   ```bash
   cd ../pokemon_api
   flutter pub get
   cd ../pokemon_klopp
   ```

### Ejecutar el Proyecto

4. Ejecuta el proyecto en un emulador o dispositivo físico:

   ```bash
   flutter run o f5 y selecciona algun dispositivo
   ```

---

## Uso del Micro Paquete `pokemon_api`

El micro paquete `pokemon_api` es una biblioteca independiente que gestiona todas las llamadas a la [PokéAPI](https://pokeapi.co/) y maneja los modelos de datos. Está incluido como dependencia local en el proyecto.

### Incluir el Micro Paquete

En el archivo `pubspec.yaml` de `pokemon_klopp`, asegúrate de incluir el paquete como dependencia local:

```yaml
dependencies:
  pokemon_api:
    path: ../pokemon_api
```

### Cómo Funciona el `pokemon_api`

1. **Modelos**: Representan los datos de los Pokémon (por ejemplo, `Pokemon`, `Ability`, `Type`, etc.).
2. **Servicio API**: `ApiService` gestiona las llamadas a la API utilizando `dio`.

---
