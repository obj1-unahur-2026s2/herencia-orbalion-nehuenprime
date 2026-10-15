class Equipo {
    var property nombre
    const property energiaBase
    const property entrenador 
    const property tecnologiasComplementarias = []

    // 1. Calculamos la base + tecnologías activas
    method energiaBaseConTecnologias() {
        const energiaTecnologias = tecnologiasComplementarias
            .filter({ tech => tech.activa() })
            .sum({ tech => tech.valorEnergetico() })
            
        return energiaBase + energiaTecnologias
    }

    // 2. Definimos un modificador por defecto (1.0 = 100%, no altera el valor)
    method modificadorDeEnergia() = 1.0

    // 3. El cálculo final que usarán todos los equipos
    method energiaTotal() = self.energiaBaseConTecnologias() * self.modificadorDeEnergia()

    method esDePrestigioUniversal() = false
}


class EquipoLuminico inherits Equipo {
    var property nivelRadiacion
    const property listaDeCristales = []

    override method modificadorDeEnergia() {
        if (nivelRadiacion <= 5000) {
            return 1.10 // Suma un 10%
        } else {
            return 1.0
        }
    }

    override method esDePrestigioUniversal() = listaDeCristales.size() >= 3 && entrenador.esDeEliteGalactico() && tecnologiasComplementarias.any({tech => tech.activa()})
}
class EquipoSintetico inherits Equipo {
    var property nivelDeProcesamiento
    var property cantModulos 
    var property estaCertificado = true

    override method modificadorDeEnergia() {
        if (cantModulos > 5) {
            return 0.80 // Penaliza restando un 20%
        } else {
            return 1.0
        }
    }
    override method esDePrestigioUniversal() = estaCertificado && cantModulos > 3 && tecnologiasComplementarias.all({tech => tech.activa()})
}
class EquipoEterico inherits Equipo {
    var property nivelFluctuacion 
    var property cantPortales

    override method esDePrestigioUniversal() = nivelFluctuacion > 75 && cantPortales >= 2 && tecnologiasComplementarias.count({ tech => tech.activa()}) >= 2

    override method modificadorDeEnergia() {
        if (self.esDePrestigioUniversal()) {
            return 1.15 // Suma un 15% adicional
        } else {
            return 1.0
        }
    }
}


class Entrenador {
    const property rolesPermitidos = [estrategaCuantico, arquitectoDeEnergia, guiaMental]
    const property cantCiclos
    const property estaEnSintonia = true
    var property precision = 0

    var rolActual

    method asignarRol(unRol){
        if(!rolesPermitidos.contains(unRol)){
            throw new DomainException(message = "Rol no homologado por la FOZ")
        }
        rolActual = unRol
    }
    method rol() = rolActual

    method esDeEliteGalactico() = cantCiclos > 10 && rolActual.condicionExtra(self)
}

object estrategaCuantico {
    method condicionExtra(entrenador) = entrenador.precision() > 80
}
object arquitectoDeEnergia {
    method condicionExtra(entrenador) = entrenador.estaEnSintonia()
}
object guiaMental {
    method condicionExtra(entrenador) = true
}

class TecnologiaEspecial{
    const property nombre
    var property valorEnergetico 
    var property activa = true
}