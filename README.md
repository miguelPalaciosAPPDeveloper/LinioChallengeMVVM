# LinioChallengeMVVM

Linio challenge using MVVM by Miguel Palacios

# Descripción
Esta aplicación ejecuta los servicio para obtener listas de favoritos y descargar las imágenes de los productos.

Utiliza un collectionView para visualizar las listas obtenidas y el total de los productos dentro de las listas.

Cuenta con una capa de networking basada en el framework [Moya]([https://github.com/Moya/Moya](https://github.com/Moya/Moya)).

La aquitectura utilizada fue MVVM con clean architecture usando observables. Para evitar el uso de otro framework implemente una clase utilizada en esta explicación y ejemplo de [MVVM]([https://tech.olx.com/clean-architecture-and-mvvm-on-ios-c9d167d9f5b3](https://tech.olx.com/clean-architecture-and-mvvm-on-ios-c9d167d9f5b3))

Esta aplicación cuenta con un loader usando el framework de lottie, por la velocidad de carga del servicio casi no se puede apreciar.

# Instrucciones

Antes de correr la aplicación ejecuta uno de los siguientes comandos.

```

carthage bootstrap --platform iOS

```
ó

```

carthage update --platform iOS

```

Para bajar el framework de lottie.


