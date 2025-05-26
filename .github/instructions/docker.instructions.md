# Buenas Prácticas para GitHub Actions con GitHub Copilot

GitHub Actions es una poderosa herramienta para automatizar flujos de trabajo de desarrollo y despliegue. GitHub Copilot puede asistir en la creación y mantenimiento de workflows eficientes, seguros y bien estructurados. A continuación, se presentan recomendaciones y ejemplos para crear workflows productivos tanto para entornos de desarrollo como de producción.

## 🏗️ Organización de Workflows y Jobs

Una buena estructura permite mayor claridad, mantenimiento y reutilización:

- **Separar por propósito**: Crear workflows individuales para diferentes propósitos (CI, CD, análisis de código, etc.).
  
  ```yaml
  # .github/workflows/ci.yml - Solo para integración continua
  name: 🚀 Continuous Integration
  
  on:
    push:
      branches: [main]
    pull_request:
      branches: [main]
  
  jobs:
    lint-build-test:
      name: Lint, Build and Test
      runs-on: ubuntu-latest
      # ...
  ```

- **Modularizar jobs**: Dividir tareas complejas en jobs más pequeños y específicos.
  
  ```yaml
  jobs:
    lint:
      name: Code Quality
      runs-on: ubuntu-latest
      # ...
    
    build:
      name: Build Application
      runs-on: ubuntu-latest
      needs: lint
      # ...
    
    test:
      name: Run Tests
      runs-on: ubuntu-latest
      needs: build
      # ...
  ```

- **Crear acciones reutilizables**: Para operaciones comunes entre múltiples workflows.
  
  ```yaml
  # .github/actions/setup-environment/action.yml
  name: 'Setup Development Environment'
  description: 'Configura Node.js y dependencias del proyecto'
  runs:
    using: 'composite'
    steps:
      - name: Set up Node.js
        uses: actions/setup-node@v4
        with:
          node-version: '18.x'
          cache: 'npm'
      
      - name: Install dependencies
        run: npm ci
        shell: bash
  ```
  
  Y su uso en workflows:
  
  ```yaml
  steps:
    - uses: actions/checkout@v4
    - uses: ./.github/actions/setup-environment
    # Continuar con pasos específicos
  ```

## 🏷️ Uso Adecuado de Secrets y Variables

Gestionar correctamente la información sensible y configuraciones:

- **Usar GitHub Secrets para información sensible**:
  
  ```yaml
  steps:
    - name: Login to Azure
      uses: azure/login@v1
      with:
        creds: ${{ secrets.AZURE_CREDENTIALS }}
  ```

- **Definir variables de entorno para configuraciones**:
  
  ```yaml
  jobs:
    deploy:
      env:
        NODE_ENV: production
        API_ENDPOINT: https://api.example.com
      steps:
        # Los pasos tendrán acceso a estas variables
  ```

- **Utilizar variables contextuales de GitHub**:
  
  ```yaml
  env:
    REPOSITORY_NAME: ${{ github.repository }}
    COMMIT_SHA: ${{ github.sha }}
    PR_NUMBER: ${{ github.event.pull_request.number }}
  ```

- **Variables a nivel de organización y repositorio**:
  Configurar variables en la interfaz de GitHub (Settings > Secrets and variables > Actions) y usarlas:
  
  ```yaml
  env:
    ENVIRONMENT: ${{ vars.ENVIRONMENT }}
  ```

## 🔄 Uso Eficiente de Acciones Existentes

Aprovechar el ecosistema de acciones del marketplace:

- **Preferir acciones oficiales o populares y verificadas**:
  
  ```yaml
  - uses: actions/checkout@v4           # Acción oficial de GitHub
  - uses: docker/setup-buildx-action@v3 # Acción mantenida por Docker
  ```

- **Fijar versiones específicas** para evitar cambios inesperados:
  
  ```yaml
  # Preferir esto (versión específica):
  - uses: actions/setup-node@v4
  
  # En lugar de esto (rama principal, puede cambiar):
  - uses: actions/setup-node@main
  ```

- **Revisar permisos y seguridad** de las acciones de terceros antes de usarlas.

- **Crear acciones personalizadas** cuando no exista una solución adecuada:
  
  ```yaml
  # .github/actions/custom-validator/action.yml
  name: 'Custom Validation'
  description: 'Valida requisitos específicos del proyecto'
  inputs:
    config-file:
      description: 'Ruta al archivo de configuración'
      required: true
  runs:
    using: 'node16'
    main: 'dist/index.js'
  ```

## 🧹 Limpieza y Mantenimiento

Mantener los workflows limpios y actualizados:

- **Documentar cada workflow** con comentarios claros:
  
  ```yaml
  # Este workflow realiza la integración continua:
  # 1. Verifica la calidad del código con ESLint
  # 2. Compila la aplicación TypeScript
  # 3. Ejecuta pruebas unitarias
  ```

- **Revisar y actualizar regularmente** las versiones de las acciones.

- **Eliminar workflows obsoletos** y consolidar los que tienen funciones similares.

- **Estructurar con nombres claros y descriptivos**:
  
  ```yaml
  name: 🚀 Deploy to Production
  
  jobs:
    security-scan:
      name: Security Validation
      # ...
    
    build-artifacts:
      name: Build Production Artifacts
      # ...
  ```

## ⏱️ Optimización de Tiempos de Ejecución

Reducir el tiempo de ejecución para feedback más rápido:

- **Utilizar caché para dependencias**:
  
  ```yaml
  - uses: actions/setup-node@v4
    with:
      node-version: '18.x'
      cache: 'npm'
      cache-dependency-path: 'package-lock.json'
  
  # Para Docker:
  - uses: docker/build-push-action@v6
    with:
      context: .
      push: false
      cache-from: type=gha
      cache-to: type=gha,mode=max
  ```

- **Ejecutar jobs en paralelo** cuando sea posible:
  
  ```yaml
  jobs:
    lint:
      # No depende de otros jobs
    
    test-unit:
      # No depende de otros jobs
    
    test-integration:
      # No depende de otros jobs
    
    build:
      needs: [lint, test-unit, test-integration]
      # Se ejecuta después de que todos los anteriores completen
  ```

- **Usar ejecución condicional** para evitar pasos innecesarios:
  
  ```yaml
  steps:
    - name: Build documentation
      if: github.event_name == 'push' && github.ref == 'refs/heads/main'
      run: npm run build:docs
  
    - name: Run full tests
      if: github.event_name == 'pull_request'
      run: npm run test:full
  ```

- **Limitar el alcance de los triggers**:
  
  ```yaml
  on:
    push:
      branches: [main]
      paths:
        - 'src/**'
        - 'package.json'
        - 'package-lock.json'
  ```

## 🛡️ Buenas Prácticas de Seguridad

Proteger el flujo de CI/CD:

- **Aplicar el principio de menor privilegio** en todos los tokens y permisos:
  
  ```yaml
  permissions:
    contents: read
    issues: write
    # Solo solicitar los permisos necesarios
  ```

- **Usar tokens de corta duración y limitados**:
  
  ```yaml
  jobs:
    deploy:
      steps:
        - uses: aws-actions/configure-aws-credentials@v4
          with:
            role-to-assume: ${{ secrets.AWS_ROLE_ARN }}
            aws-region: us-east-1
  ```

- **Verificar las entradas externas** antes de utilizarlas:
  
  ```yaml
  - name: Validate input
    run: |
      if [[ ! ${{ github.event.inputs.environment }} =~ ^(dev|staging|prod)$ ]]; then
        echo "Invalid environment specified"
        exit 1
      fi
  ```

- **Escanear secretos y vulnerabilidades**:
  
  ```yaml
  - name: Run security scan
    uses: snyk/actions/node@master
    with:
      args: --severity-threshold=high
  ```

## 📦 Separación de Workflows para Distintas Etapas

Estructurar workflows según el ciclo de vida del desarrollo:

- **CI (Integración Continua)**:
  
  ```yaml
  # .github/workflows/ci.yml
  name: CI
  on:
    pull_request:
      branches: [main, develop]
  
  jobs:
    verify:
      # Lint, compilación, pruebas unitarias
  ```

- **CD (Entrega Continua) para entornos de desarrollo**:
  
  ```yaml
  # .github/workflows/cd-development.yml
  name: Deploy to Development
  on:
    push:
      branches: [develop]
  
  jobs:
    deploy-dev:
      # Despliegue a entorno de desarrollo
  ```

- **CD para producción con aprobación manual**:
  
  ```yaml
  # .github/workflows/cd-production.yml
  name: Deploy to Production
  on:
    workflow_dispatch:
    release:
      types: [published]
  
  jobs:
    deploy-prod:
      environment:
        name: production
        url: https://api.example.com
      # Requiere aprobación manual por las configuraciones de ambiente
  ```

- **Workflows auxiliares** para tareas específicas:
  
  ```yaml
  # .github/workflows/dependency-updates.yml
  name: Dependency Updates
  on:
    schedule:
      - cron: '0 0 * * 1' # Cada lunes
  
  jobs:
    update-deps:
      # Actualizar dependencias y crear PR
  ```

## 📝 Documentación de Workflows

Mantener una documentación clara para cada workflow:

- **Incluir descripción al inicio del archivo**:
  
  ```yaml
  # .github/workflows/deploy.yml
  #
  # Deploy Workflow
  # ---------------
  # Este workflow despliega la aplicación en el entorno especificado.
  #
  # Inputs:
  #   environment: (dev|staging|prod) - Entorno de despliegue
  #
  # Secrets requeridos:
  #   - AZURE_CREDENTIALS: Credenciales de Azure
  #   - DEPLOYMENT_TOKEN: Token para el despliegue
  ```

- **Documentar variables y secretos** necesarios.

- **Mantener un diagrama de flujo** de los procesos de CI/CD en la wiki o documentación del proyecto.

- **Explicar decisiones arquitectónicas** y patrones utilizados.

## 🤖 Cómo GitHub Copilot puede ayudar

GitHub Copilot puede asistir en la creación y mantenimiento de workflows de GitHub Actions:

- **Sugerir estructuras de workflows** basadas en comentarios o requisitos.
  ```
  # Workflow para CI que incluya lint, build y test con Node.js
  ```

- **Completar sintaxis YAML** específica de GitHub Actions.

- **Recomendar acciones populares** para tareas comunes.

- **Generar estructuras de jobs** para escenarios típicos.

- **Sugerir condiciones y expresiones** para controles condicionales.

- **Identificar problemas potenciales** en la configuración existente.

Para aprovechar mejor las sugerencias de Copilot:

1. Describe claramente el propósito del workflow en comentarios.
2. Especifica los requisitos técnicos (lenguaje, plataforma).
3. Indica el patrón que deseas seguir (CI, CD, análisis de código, etc.).
4. Revisa y valida las sugerencias generadas.

## 🛠️ Mantenimiento de esta Sección

Para contribuir a esta sección de buenas prácticas:

1. Revisa periódicamente las prácticas recomendadas de GitHub Actions.
2. Actualiza los ejemplos con las últimas versiones de acciones.
3. Añade nuevos patrones que hayan demostrado ser efectivos en el proyecto.
4. Documenta cualquier problema encontrado y sus soluciones.
5. Comparte conocimientos sobre optimizaciones específicas para este proyecto.
