(() => {
    const today = new Date().toISOString().split("T")[0];

    document.querySelectorAll("input[data-min-today]").forEach((input) => {
        input.min = today;
    });

    document.querySelectorAll("input[data-max-today]").forEach((input) => {
        input.max = today;
    });

    document.querySelectorAll("form[data-confirm]").forEach((form) => {
        form.addEventListener("submit", (event) => {
            const message = form.getAttribute("data-confirm") || "Deseas continuar?";
            if (!window.confirm(message)) {
                event.preventDefault();
            }
        });
    });

    document.querySelectorAll("input[inputmode='numeric']").forEach((input) => {
        input.addEventListener("input", () => {
            input.value = input.value.replace(/\D+/g, "");
        });
    });
})();
