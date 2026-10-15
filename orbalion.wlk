class Equipo {
    var property nombre
    const property energiaBase
    const property entrenador 
    const property tecnologiasComplementarias = []

    method energiaTotal() = energiaBase 
}


class EquipoLuminico inherits Equipo {
    var property nivelRadiacion
    const property listasDeCristales = []
}
class EquipoSintetico inherits Equipo {
    var property nivelDeProcesamiento
    var property cantModulos 
    var property estaCertificado = true
}
class EquipoEterico inherits Equipo {
    var property nivelFluctuacion 
    var property cantPortales
}


class Entrenador {
    const property rolesPermitidos = [estrategaCuantico, arquitectoDeEnergia, guiaMental]
    const property cantCiclos
    const property estaEnSintonia = true
    var property precision = 0

    var rolActual

    method rolDelCoordinador(unRol){
        if(!rolesPermitidos.contains(unRol)){
            throw new DomainException(message = "Rol no homologado por la FOZ")
        }
        rolActual = unRol
    }
    method rol() = rolActual
}

object estrategaCuantico {}
object arquitectoDeEnergia {}
object guiaMental {}

class TecnologiaEspecial{
    const property nombre
    var property valorEnergetico 
    var property activa = true
}