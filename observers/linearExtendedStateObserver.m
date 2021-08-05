function estimatedExtendedStateDerivative = linearExtendedStateObserver(previousEstimatedExtendedState,...
        controlError,...
        controlSignal,...
        dynamicsOrder,...
        inputGainParameter,...
        observerBandwidth)
    
    A = calculateObserverStateMatrix(dynamicsOrder);
    B = calculateObserverInputMatrix(inputGainParameter, dynamicsOrder);
    L = calculateObserverGainVector(observerBandwidth, dynamicsOrder);
    
    estimatedExtendedStateDerivative = A * previousEstimatedExtendedState +...
        B * controlSignal +...
        L * (controlError - previousEstimatedExtendedState(1));
end

function observerStateMatrix = calculateObserverStateMatrix(dynamicsOrder)
    observerStateMatrix = [zeros(dynamicsOrder,1), eye(dynamicsOrder);...
        zeros(1,dynamicsOrder+1)];
end

function observerInputMatrix = calculateObserverInputMatrix(inputGainParameter, dynamicsOrder)
    observerInputMatrix = [zeros(dynamicsOrder-1,1); -inputGainParameter; 0];
end

function observerGainVector = calculateObserverGainVector(observerBandwidth, dynamicsOrder)
    extendedGainVector = poly(-observerBandwidth * ones(1, dynamicsOrder+1))';
    observerGainVector = extendedGainVector(2:end);
end